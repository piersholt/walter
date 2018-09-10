# events.rb
module Event
  # Channel
  BUS_OFFLINE = :offline
  BUS_ONLINE = :online
  BUS_BUSY = :busy
  BUS_IDLE = :idle
  BUS_ACTIVE = :active
  BYTE_RECEIVED = :read_byte

  # Receiver
  FRAME_RECEIVED = :frame_received
  FRAME_FAILED = :frame_failed

  # top layer?
  MESSAGE_RECEIVED = :message_received

  # user configuration events
  MESSAGE_DISPLAY = :message_display

  # APPLICATION
  STATUS_REQUEST = :thread_status_request
  EXIT = :exit

  CHANNEL_EVENTS  = [BYTE_RECEIVED, BUS_OFFLINE, BUS_ONLINE, BUS_BUSY, BUS_IDLE, BUS_ACTIVE].freeze
  RECEIVER_EVENTS = [FRAME_RECEIVED, FRAME_FAILED].freeze
  LAYER_EVENTS    = [MESSAGE_RECEIVED].freeze
  USER_EVENTS     = [MESSAGE_DISPLAY].freeze
  APP_EVENTS      = [STATUS_REQUEST, EXIT].freeze

  ALL_EVENTS = (CHANNEL_EVENTS + RECEIVER_EVENTS + LAYER_EVENTS + USER_EVENTS + APP_EVENTS).freeze

  def valid?(event)
    ALL_EVENTS.one? { |e| e == event }
  end
end
