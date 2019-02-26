# frozen_string_literal: true

# Simulated CD Changer
module Telephone
  include Stateful
  include API::Telephone

  PROC = 'SimTelephone'

  WAIT_DEFAULT = 0.01

  CONTACTS = ['A.Anteater',
              'B.Bonkers',
              'C.Cockatoo',
              'D.Donkey',
              'E.Eagle',
              'F.Fatty',
              'G.Gonzo',
              'H.Henderson',
              'I.India',
              'J.Jamie',
              'K.Karen',
              'L.Lorenzo',
              'M.Mario',
              'N.Nelly',
              'O.Ophelia',
              'P.Porridge'].freeze

  # COMMANDS ------------------------------------------------------------------

  # PONG 0x02
  ANNOUNCE = 0x01

  # TXT-MID 0X21
  CONTACT_DISPLAY_LIMIT = 8
  CONTACT_PAGE_SIZE = 2

  CONTACT_DELIMITER = 6

  DRAW_DIAL = 0x42
  DRAW_DIRECTORY = 0x43
  DRAW_FAVOURITES = 0x80

  MID_DEFAULT = 0x01

  PAGE = { 0 => 0b0110_0000,
           1 => 0b0100_0100,
           2 => 0b0101_0000,
           3 => 0b0001_0100 }.freeze
  NO_PAGINATION = 0b0010_0000
  CLEAR = [].freeze

  # GFX STATUS 0x22
  STATUS_CLEAR = 0x00
  STATUS_HOME_SUCCESS = 0x02
  STATUS_SUCCESS = 0x03
  STATUS_ERROR = 0xFF

  # TEL-DATA 0x31
  SOURCE_INFO = 0x20
  SOURCE_DIAL = 0x42
  SOURCE_DIR = 0x43
  SOURCE_TOP = 0x80

  ACTION_DIR_OPEN = 0x1F
  ACTION_DIR_BACK = 0x0C
  ACTION_DIR_FORWARD = 0x0D

  ACTION_INFO_OPEN = 0x0A
  ACTION_DIAL_OPEN = 0x1E

  # VALUES ------------------------------------------------------------------

  LED_OFF = 0b0000_0000
  LED_ALL = 0b0001_0101

  LED_RED = 0b0000_0001
  LED_RED_BLINK = 0b0000_0010

  LED_YELLOW = 0b0000_0100
  LED_YELLOW_BLINK = 0b0000_1000

  LED_GREEN = 0b0001_0000
  LED_GREEN_BLINK = 0b0010_0000

  TEL_OFF = LED_OFF
  TEL_POWERED = LED_GREEN

  # Helpers  ------------------------------------------------------------------

  def ready
    LOGGER.unknown(PROC) { "Telephone ready macro!" }
    raise StandardError, 'who calls this?'
    tel_led(LED_OFF)
    tel_state(TEL_OFF)
    announce
    sleep(0.25)
    tel_state(TEL_POWERED)
    # tel_led(LED_ALL)
    bluetooth_pending
  rescue StandardError => e
    e.backtrace.each { |line| puts line }
  end

  def bluetooth_pending
    LOGGER.unknown(PROC) { 'Bluetooth connection pending...' }
    tel_led(LED_YELLOW_BLINK)
  end

  def bluetooth_connecting
    LOGGER.unknown(PROC) { 'Telephone connecting...' }
    tel_led(LED_GREEN_BLINK)
  end

  def bluetooth_connected
    LOGGER.unknown(PROC) { 'Telephone connected!' }
    tel_led(LED_GREEN)
  end

  def bluetooth_disconnecting
    LOGGER.unknown(PROC) { 'Telephone disconnecting...' }
    tel_led(LED_RED_BLINK)
  end

  def bluetooth_disconnected
    LOGGER.unknown(PROC) { 'Telephone disconnected...' }
    tel_led(LED_RED)
  end

  # Displaying Drawing  -------------------------------------------------------

  def clear(display)
    LOGGER.unknown(PROC) { "Mock: clearing :#{display}!" }

    m1 =
      case display
      when :directory
        DRAW_DIRECTORY
      when :favourites
        DRAW_FAVOURITES
      end

    mid(m1: m1, m2: MID_DEFAULT, m3: NO_PAGINATION, chars: CLEAR)
  end

  def directory
    contact_groups = generate_contacts(CONTACT_DISPLAY_LIMIT,
                                       CONTACT_PAGE_SIZE,
                                       false)

    contact_groups.each_with_index do |contact_group, i|
      directory_page(contact_group, i)
    end
  end

  def favourites
    contact_groups = generate_contacts(CONTACT_DISPLAY_LIMIT,
                                       CONTACT_PAGE_SIZE,
                                       false)

    contact_groups.each_with_index do |contact_group, i|
      favourites_page(contact_group, i)
    end
  end

  # Helpers  ------------------------------------------------------------------

  def generate_contacts(number_of_contacts = 1,
                        contacts_per_group = CONTACT_PAGE_SIZE,
                        inversed = false)
    group_count = number_of_contacts.fdiv(contacts_per_group).ceil

    Array.new(group_count) do |group_index|
      full_char_array = Array.new(contacts_per_group) do |contact_index|
        i = (group_index * contacts_per_group) + contact_index
        contacts = generate_contact(i, inversed)
        char_array = contacts.bytes
        char_array.insert(0, CONTACT_DELIMITER)
      end

      full_char_array.flatten
    end
  end

  def generate_contact(position = 1, inverse = false)
    contacts = CONTACTS.dup
    # contacts = CONTACTS.dup.shuffle
    contacts.reverse! if inverse
    contacts[position]
  end

  # Delegates  -----------------------------------------------------------------

  def delegate_directory(action)
    LOGGER.unknown(PROC) { "Mock: handling directory..." }
    if action == ACTION_DIR_BACK
      LOGGER.unknown(PROC) { "Mock: oh, directory pages back!" }
      render_pending_clearance(:directory)
    elsif action == ACTION_DIR_FORWARD
      LOGGER.unknown(PROC) { "Mock: oh, directory pages forward!" }
      render_pending_clearance(:directory)
    elsif action == ACTION_DIR_OPEN
      LOGGER.unknown(PROC) { "Mock: oh, directory pages forward!" }
      render_pending_clearance(:directory)
    else
      false
    end
  end

  STRENGTH = [0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0x5F, 0xB8].freeze
  # 0x93: Call cost current
  # 0x94: Call cost total
  # 0x96: Call Time minutes
  # 0x97: Call time seconds
  def delegate_info
    hud(from: :tel, to: :gfx, gfx: 0x91, ike: 0x00, chars: [STRENGTH.shuffle.first])
    hud(from: :tel, to: :gfx, gfx: 0x93, ike: 0x00, chars: '123456789abcdef'.bytes)
    hud(from: :tel, to: :gfx, gfx: 0x94, ike: 0x00, chars: '123456789abcdef'.bytes)
    hud(from: :tel, to: :gfx, gfx: 0x96, ike: 0x00, chars: '123456789abcdef'.bytes)
    hud(from: :tel, to: :gfx, gfx: 0x97, ike: 0x00, chars: '123456789abcdef'.bytes)
  end

  def delegate_favourites
    LOGGER.unknown(PROC) { "Mock: handling favourites..." }
    LOGGER.unknown(PROC) { "Mock: oh, directory open!!" }
    render_pending_clearance(:favourites)
  end

  # private

  # xxx  -----------------------------------------------------------------

  def directory_page(contact_group, i)
    mid(m1: DRAW_DIRECTORY, m2: MID_DEFAULT, m3: PAGE[i], chars: contact_group)
    page_wait
  end

  def favourites_page(contact_group, i)
    mid(m1: DRAW_FAVOURITES, m2: MID_DEFAULT, m3: PAGE[i], chars: contact_group)
    page_wait
  end

  def page_wait
    Kernel.sleep(WAIT_DEFAULT)
  end

  # API calls  ----------------------------------------------------------------

  # def tel_display
  #   to_id = address(:gfx)
  #
  #   args = { gfx: 0x80, ike: 0x20, chars: '' }
  #   # displays(args, my_address, to_id)
  #   displays(gfx: 0x80, ike: 0x20, chars: '')
  # end

  def tel_state(telephone_state = TEL_OFF)
    status(status: telephone_state)
  end

  def tel_led(value = LED_ALL)
    led(leds: value)
  end

  # Handlers ------------------------------------------------------------------

  def handle_tel_open(message)
    LOGGER.unknown(PROC) { "Mock: handling telephone tel open request..." }
    # delegate_favourites
    mid(m1: DRAW_DIAL, m2: MID_DEFAULT, m3: 0x00, chars: [])
  end

  # Piggyback off the radio announce to annunce
  def handle_announce(message)
    # LOGGER.warn('SimulatedTEL') { "handling pong: #{message.from}" }
    # LOGGER.warn('SimulatedTEL') { "message.from?(:rad) => #{message.from?(:rad)}" }

    return false unless message.from?(:gfx)
    return false unless message.command.status.value == ANNOUNCE
    LOGGER.info(PROC) { "GFX has announced. Piggybacking (sic)" }
    ready
    true
  end

  def handle_data_request(message)
    LOGGER.unknown(PROC) { "Mock: handling telephone data request..." }
    # source = message.command.source
    # case source
    # when SOURCE_INFO
    #   handle_info(message)
    # when SOURCE_DIAL
    #   handle_dial(message)
    # when SOURCE_DIR
    #   directory(message)
    # when SOURCE_TOP
    #   handle_top(message)
    # end
    source = message.command.source.value
    function = message.command.function.value
    action = message.command.action.value
    case action
    when ACTION_DIAL_OPEN
      mid(m1: DRAW_DIAL, m2: MID_DEFAULT, m3: 0x00, chars: [])
    when ACTION_DIR_OPEN
      delegate_directory(action)
    when ACTION_DIR_BACK
      delegate_directory(action)
    when ACTION_DIR_FORWARD
      delegate_directory(action)
    when ACTION_INFO_OPEN
      delegate_info
    end
  end

  def handle_gfx_status(message)
    LOGGER.unknown(PROC) { "Mock: handling GFX status..." }
    if message.command.status.value == STATUS_CLEAR
      LOGGER.unknown(PROC) { "Mock: GFX status clear!" }
      release_pending_render
    elsif message.command.status.value == STATUS_SUCCESS
      LOGGER.unknown(PROC) { "Mock: GFX status success!" }
      clear_retry
    elsif message.command.status.value == STATUS_HOME_SUCCESS
      LOGGER.unknown(PROC) { "Mock: GFX menu status success!" }
      clear_retry
    elsif message.command.status.value == STATUS_ERROR
      LOGGER.unknown(PROC) { "Mock: GFX status error!" }
      release_pending_retry
    end
  end

  # Transmission State  -----------------------------------------------------------------

  def render_pending_clearance(method)
    LOGGER.unknown(PROC) { "Mock: Being drawing :#{method}" }
    # LOGGER.unknown(PROC) { "Mock: Firstly clear display :#{method}" }
    clear(method)
    LOGGER.unknown(PROC) { "Mock: Register :#{method} as pending..." }
    @render_pending = method
    true
  end

  def release_pending_retry
    LOGGER.unknown(PROC) { "Mock: seeing is a render is pending...." }
    if @render_retry.nil?
      LOGGER.unknown(PROC) { 'Mock: No render retry......' }
    else
      LOGGER.unknown(PROC) { "Mock: retrying: :#{@render_retry}" }
      public_send(@render_retry)
    end
  end

  def release_pending_render
    LOGGER.unknown(PROC) { "Mock: seeing is a render is pending...." }
    if @render_pending.nil?
      LOGGER.unknown(PROC) { 'Mock: No render pending...' }
    else
      LOGGER.unknown(PROC) { "Mock: releasing: :#{@render_pending}" }
      public_send(@render_pending)
      @render_retry = @render_pending
      @render_pending = nil
    end
  end

  def clear_retry
    # LOGGER.unknown(PROC) { "Mock: no need to try #{@render_retry} again!" }
    @render_retry = nil
  end

  # Stateful  -----------------------------------------------------------------

  DEFAULT_STATE = {
    active: 0,
    power: 0,
    display: 0,
    incoming: 0,
    menu: 0,
    hfs: 0
  }.freeze

  def default_state
    DEFAULT_STATE.dup
  end
end
