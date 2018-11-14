# frozen_string_literal: true

# Simulated CD Changer
module CD
  include Stateful
  include API::CD

  SCAN_THRESHOLD_SECONDS = 3

  # 0x38
  REQUEST = { status: 0x00, stop: 0x01, play: 0x03, seek: 0x04,
              skip: 0x05, change_disc: 0x06 }.freeze

  # 0x39
  CONTROL = { off: 0x00, start: 0x02, next: 0x03, previous: 0x04,
              fwd: 0x05, rwd: 0x06, stop: 0x07, changed: 0x08 }.freeze
  STATUS = { no: 0x02, yes: 0x09 }.freeze

  DEFAULT_LOADER = 0b0011_1111

  DEFAULT_STATE = {
    control: CONTROL[:off],
    status: STATUS[:no],
    loader: DEFAULT_LOADER,
    cd: 1,
    track: 1,
    b2: 0,
    b4: 0
  }.freeze

  def handle_changer_request(message)
    command = message.command
    control = command.control
    LOGGER.unknown(ident) do
      "Analysing CD changer command. Control: #{control} (#{control.value})"
    end

    delegate_changer_request(command)
    status
  end

  def default_state
    DEFAULT_STATE.dup
  end

  def delegate_changer_request(command)
    control = command.control
    case control.value
    when REQUEST[:status]
      handle_status_request
    when REQUEST[:stop]
      handle_stop
    when REQUEST[:play]
      handle_play
    when REQUEST[:skip]
      handle_skip(command)
    when REQUEST[:seek]
      handle_seek(command)
    when REQUEST[:change_disc]
      handle_change_disc(command)
      status
      handle_play
    else
      LOGGER.error(ident) { "Nothing matches: #{control}?" }
      return false
    end
  end

  def status(report_state = state)
    from_id = my_address
    to_id = address(:rad)

    changer(report_state, from_id, to_id)
  end

  # Intervals for FFD/RWD vs. Next/Previous

  def only_skip_track?
    elapased_time <= SCAN_THRESHOLD_SECONDS
  end

  # Radio Request Handling

  def handle_status_request
    LOGGER.unknown(ident) { 'Handling CDC status.' }

    status
  end

  def handle_stop
    LOGGER.unknown(ident) { 'Handling disc stop.' }

    new_state = { control: CONTROL[:stop],
                  status: STATUS[:no] }
    state!(new_state)
  end

  def current_track
    state[:track]
  end

  def next_track
    current_track + 1
  end

  def previous_track
    current_track - 1
  end

  def current_control
    state[:control]
  end

  def handle_play
    LOGGER.unknown(ident) { 'Handling disc play.' }
    state! control: CONTROL[:start], status: STATUS[:yes]
    case current_control
    when CONTROL[:fwd]
      state! track: next_track if only_skip_track?
    when CONTROL[:rwd]
      state! track: previous_track if only_skip_track?
    when CONTROL[:off]
      state! cd: 1, track: 1
    else
      state! cd: 7, track: 99
    end
  end

  def handle_skip(command)
    LOGGER.unknown(ident) { 'Handling track skip.' }

    mode = command.mode

    if mode.value.zero?
      control = CONTROL[:next]
      track = next_track
    elsif mode.value == 1
      control = CONTROL[:previous]
      track = previous_track
    end

    state! control: control, status: STATUS[:no], track: track
    start_timer
  end

  def handle_seek(command)
    LOGGER.unknown(ident) { 'Handling track scan.' }

    mode = command.mode

    if mode.value.zero?
      control = CONTROL[:fwd]
    elsif mode.value == 1
      control = CONTROL[:rwd]
    end

    state! control: control, status: STATUS[:no]
    start_timer
  end

  def handle_change_disc(command)
    LOGGER.unknown(ident) { 'Handling disc change.' }

    requested_disc = command.mode
    LOGGER.debug(ident) { "Requested disc: #{requested_disc.value}" }

    new_state = { control: CONTROL[:changed],
                  status: STATUS[:yes],
                  cd: requested_disc.value,
                  track: 1 }
    state!(new_state)
  end
end
