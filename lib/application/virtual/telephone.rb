# frozen_string_literal: true

# Simulated CD Changer
module Telephone
  include Stateful
  include API::Telephone
  include API::Media

  # make all the contacts one character....
  # i want to try and have to display more or less than two contacts per message
  # and see what it does to render it
  # if it donesn't just do... 2 at a time... then the idea of a four zone code is totally wrong...

  # VALUES ------------------------------------------------------------------

  LED_OFF = 0b0000_0000
  LED_ALL = 0b0001_0101
  TEL_OFF = 0b0000_0000
  TEL_POWERED = 0b0001_0000

  PROC = 'SimTelephone'

  # COMMANDS ------------------------------------------------------------------

  WAIT_DEFAULT = 0.01

  # PONG 0x02
  ANNOUNCE = 0x01

  # TXT-MID 0X21
  CONTACT_DISPLAY_LIMIT = 8
  CONTACT_PAGE_SIZE = 2

  CONTACT_DELIMITER = 6

  DRAW_DIRECTORY = 0x43
  DRAW_TOP_8 = 0x80

  MID_DEFAULT = 0x01

  PAGE = { 0 => 0b0110_0000, 1 => 0b0100_0100,
           2 => 0b0101_0000, 3 => 0b0001_0100 }.freeze
  NO_PAGINATION = 0b0010_0000
  CLEAR = [].freeze

  # GFX STATUS 0x22
  STATUS_CLEAR = 0x00
  STATUS_GOOD = 0x03

  # TEL-DATA 0x31
  SOURCE_INFO = 0x20
  SOURCE_DIAL = 0x42
  SOURCE_DIR = 0x43
  SOURCE_TOP = 0x80

  ACTION_DIR_BACK = 0x0C
  ACTION_DIR_FORWARD = 0x0D

  # Handlers ------------------------------------------------------------------

  def handle_tel_open(message)
    LOGGER.unknown(PROC) { "Mock: handling telephone tel open request..." }
    delegate_favourites(message)
  end

  # Piggyback off the radio announce to annunce
  def handle_announce(message)
    return false unless message.from?(:rad)
    LOGGER.unknown(PROC) { "Mock: handling Announce!" }
    return false unless message.command.status.value == ANNOUNCE
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
    #   handle_directory(message)
    # when SOURCE_TOP
    #   handle_top(message)
    # end

    action = message.command.action.value
    case action
    when ACTION_DIR_BACK
      handle_directory(message)
    when ACTION_DIR_FORWARD
      handle_directory(message)
    end
  end

  def handle_gfx_status(message)
    LOGGER.unknown(PROC) { "Mock: handling GFX status..." }
    if message.command.status.value == STATUS_CLEAR
      LOGGER.unknown(PROC) { "Mock: GFX status clear!" }
      release_pending_render
    elsif message.command.status.value == STATUS_GOOD
      LOGGER.unknown(PROC) { "Mock: GFX status success!" }
      clear_retry
    end
  end

  # Delegates  -----------------------------------------------------------------

  def handle_directory(message)
    LOGGER.unknown(PROC) { "Mock: handling directory..." }
    if message.command.action.value == ACTION_DIR_BACK
      LOGGER.unknown(PROC) { "Mock: oh, directory pages back!" }
      render_pending_clearance(:directory)
    elsif message.command.action.value == ACTION_DIR_FORWARD
      LOGGER.unknown(PROC) { "Mock: oh, directory pages forward!" }
      render_pending_clearance(:directory)
    else
      false
    end
  end

  def delegate_favourites(message)
    LOGGER.unknown(PROC) { "Mock: handling favourites..." }
    render_pending_clearance(:favourites)
  end

  # Transmission State  -----------------------------------------------------------------

  def render_pending_clearance(method)
    LOGGER.unknown(PROC) { 'Mock: Cleaning Display' }
    # clear
    LOGGER.unknown(PROC) { "Mock: Now registering :#{method} as pending..." }
    @render_pending = method
    true
  end

  def release_pending_render
    LOGGER.unknown(PROC) { "Mock: seeing is a render is pending...." }
    if @render_pending.nil?
      LOGGER.unknown(PROC) { 'Mock: No render pending...' }
    else
      LOGGER.unknown(PROC) { "Mock: releasing: :#{@render_pending}" }
      # public_send(@render_pending)
      @render_retry = @render_pending
      @render_pending = nil
    end
  end

  def clear_retry
    LOGGER.unknown(PROC) { "Mock: no need to try #{@render_retry} again!" }
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

  # API calls  ----------------------------------------------------------------

  def tel_display
    to_id = address(:gfx)

    args = { gfx: 0x80, ike: 0x20, chars: '' }
    displays(args, my_address, to_id)
  end

  def tel_state(telephone_state = TEL_OFF)
    to_id = address(:anzv)

    status({ status: telephone_state }, my_address, to_id)
  end

  def tel_led(value = LED_ALL)
    to_id = address(:anzv)

    led({ leds: value }, my_address, to_id)
  end

  # Helpers  ------------------------------------------------------------------

  def ready
    tel_led(LED_OFF)
    tel_state(TEL_OFF)
    announce
    sleep(0.25)
    tel_state(TEL_POWERED)
    tel_led(LED_ALL)
  end

  PARAMETER_LENGTH_MAX = 20

  def clear
    to_id = address(:gfx)

    command_arguments = {}
    command_arguments[:m1]    = DRAW_DIRECTORY
    command_arguments[:m2]    = MID_DEFAULT
    command_arguments[:m3]    = NO_PAGINATION
    command_arguments[:chars] = CLEAR

    mid(command_arguments, my_address, to_id)
  end

  def directory
    to_id = address(:gfx)
    contact_groups = generate_contacts(CONTACT_DISPLAY_LIMIT,
                                       CONTACT_PAGE_SIZE,
                                       false)

    contact_groups.each_with_index do |contact_group, i|
      directory_page(contact_group, i)
    end
  end

  def favourites
    to_id = address(:gfx)

    contact_groups = generate_contacts(CONTACT_DISPLAY_LIMIT,
                                       CONTACT_PAGE_SIZE,
                                       false)

    contact_groups.each_with_index do |contact_group, i|
      favourites_page(contact_group, i)
    end
  end

  def directory_page(contact_group, i)
    command_arguments = {}
    command_arguments[:m1] = DRAW_DIRECTORY
    command_arguments[:m2] = MID_DEFAULT
    command_arguments[:m3] = PAGE[i]
    command_arguments[:chars] = contact_group

    mid(command_arguments, my_address, to_id)
    page_wait
  end

  def favourites_page(contact_group, i)
    command_arguments = {}
    command_arguments[:m1] = DRAW_TOP_8
    command_arguments[:m2] = MID_DEFAULT
    command_arguments[:m3] = PAGE[i]
    command_arguments[:chars] = contact_group

    mid(command_arguments, my_address, to_id)
    page_wait
  end

  def page_wait
    Kernel.sleep(WAIT_DEFAULT)
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

  # Max contact name length is 13
  # it will message two contacts in one message for a total of 28 bytes

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

  def generate_contact(position = 1, inverse = false)
    contacts = CONTACTS.dup
    contacts.reverse! if inverse
    contacts[position]
  end
end
