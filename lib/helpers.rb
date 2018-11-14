require 'helpers/manageable_threads'
require 'helpers/delayable'

module ModuleTools
  # Retrieve a constant from a String i.e. "NameSpaceA::ClassX"
  def get_class(name)
    Kernel.const_get(name)
  end

  def prepend_namespace(command_namespace, klass)
    "#{command_namespace}::#{klass}"
  end
end

module DeviceTools
  MEDIA = [:cdc, :cd, :rad, :dsp, :gfx, :tv, :bmbt]
  CD = [:cdc, :cd, :rad, :gfx, :bmbt]
  TELEPHONE = [:tel, :ike, :rad, :gfx, :anzv, :bmbt]
  BROADCAST = [:glo_h, :glo_l]
end

module CommandAliases
  PING = 0x01
  PONG = 0x02

  IGNITION_REQ  = 0x10
  IGNITION      = 0x11

  SENSORS_REQ   = 0x12
  SENSORS       = 0x13

  CNTRY_REQ   = 0x14
  CNTRY       = 0x15

  ODO_REQ   = 0x16
  ODO       = 0x17

  SPEED     = 0x18
  LAMP_REQ  = 0x5A
  LAMP      = 0x5B

  DOOR_REQ = 0x79
  DOOR = 0x7A

  VEH_REQ   = 0x53
  VEH       = 0x54

  TEMP_REQ = 0x1D
  TEMP = 0x19

  DSP_EQ = 0x34
  RAD_EQ = 0x36

  REMOTE    = 0x72
  KEY_REQ   = 0x73
  KEY       = 0x74

  TEL_OPEN   = 0x20
  TEL_LED   = 0x2B
  TEL_STATE = 0x2C
  TEL_DATA  = 0x31

  HUD_TEXT = 0x24

  RAD_LED = 0x4A
  SRC_CTL = 0x4B
  SND_SRC = 0x4E

  RAD_CONFIG = 0x45
  RAD_STATUS = 0x46

  GFX_STATUS = 0x22

  CHANGER_REQUEST = 0x38
end

module CommandTools
  KEEP_ALIVE = [0x01, 0x02].freeze
  SPEED = [0x18].freeze
  TEMPERATURE = [0x1D, 0x19].freeze
  IGNITION = [0x10, 0x11].freeze
  IKE_SENSOR = [0x12, 0x13].freeze
  COUNTRY = [0x14, 0x15].freeze

  MID_TXT = [0x21].freeze

  OBC = [0x2A, 0x40, 0x41].freeze

  BUTTON = [0x48, 0x49].freeze

  VEHICLE = [0x53, 0x54].freeze
  LAMP = [0x5A, 0x5B].freeze
  DOOR = [0x79, 0x7A].freeze

  CD_CHANGER = [0x38, 0x39].freeze

  NAV = [0x4f].freeze

  DIA = [0x00, 0x04, 0x05, 0x08, 0x0B, 0x0C, 0x30, 0x3F, 0x60, 0x6B, 0x69, 0x65, 0x9C, 0x9F, 0xA2, 0xA0, 0x06, 0x07, 0x09, 0x1b].freeze
end

# WalterTools
# Helpers for common tasks on CLI
module WalterTools
  PROC_MOD = 'WalterTools'.freeze
  include CommandTools

  def defaults
    LOGGER.info(PROC_MOD) { 'Applying debug defaults.' }
  end

  # Session

  def messages
    SessionHandler.i.messages
  end

  # DisplayHandler

  def s
    DisplayHandler.instance.enable
  end

  def h
    DisplayHandler.instance.disable
  end

  # DisplayHandler FILTERING

  def diag
    DisplayHandler.i.filter_commands(*CommandTools::DIA)
  end

  def obc
    DisplayHandler.i.filter_commands(*CommandTools::OBC)
  end

  def ping
    DisplayHandler.i.filter_commands(*CommandTools::KEEP_ALIVE)
  end

  def shutup!
    DisplayHandler.i.shutup!
  end

  def ign
    DisplayHandler.i.filter_commands(*CommandTools::IGNITION)
  end

  def tel
    DisplayHandler.i.f_t(* DeviceTools::TELEPHONE + DeviceTools::BROADCAST)
    DisplayHandler.i.f_f(*DeviceTools::TELEPHONE)
    DisplayHandler.i.h_c(* SPEED + TEMPERATURE + COUNTRY + VEHICLE + LAMP + IKE_SENSOR + OBC + KEEP_ALIVE + IGNITION + [CommandAliases::HUD_TEXT] )
    DisplayHandler.i.h_c(* [CommandAliases::RAD_LED, CommandAliases::SRC_CTL, CommandAliases::SND_SRC, CommandAliases::RAD_CONFIG, CommandAliases::RAD_STATUS])
  end

  def cd
    DisplayHandler.i.f_t(* DeviceTools::CD)
    DisplayHandler.i.f_f(* DeviceTools::CD)
    DisplayHandler.i.h_c(* SPEED + TEMPERATURE + COUNTRY + VEHICLE + LAMP + IKE_SENSOR + OBC + IGNITION + [CommandAliases::HUD_TEXT] )
    DisplayHandler.i.h_c(* [])
  end

  def c
    DisplayHandler.i.clear_filter
  end

  def media
    DisplayHandler.i.f_t(* DeviceTools::MEDIA + BROADCAST )
    DisplayHandler.i.f_f(*DeviceTools::MEDIA)
  end

  # Logging

  def debug
    LOGGER.sev_threshold=(Logger::DEBUG)
  end

  def info
    LOGGER.sev_threshold=(Logger::INFO)
  end

  # Annoying Tasks :)

  def hello?
    t0 = messages.count
    Kernel.sleep(1)
    t1 = messages.count
    r = t1 - t0
    LOGGER.info(PROC_MOD) { "#{r} new messages in the last second." }
    r.positive? ? true : false
  end

  def news
    print_status(true)
    true
  end

  def nl
    new_line_thread = Thread.new do
      Thread.current[:name] = 'New Line'
      Kernel.sleep(0.5)
      LOGGER.unknown('Walter') { 'New Line' }
    end
    add_thread(new_line_thread)
  end

  # Delay

  def rate(seconds)
    @interface.sleep_time = seconds
  end

  def sleep
    @interface.sleep_enabled = true
    sleep_time = @interface.sleep_time
    LOGGER.info(PROC) { "Sleep ENABLED with rate of #{sleep_time} seconds" }
    sleep_time
  end

  def no_sleep
    @interface.sleep_enabled = false
    sleep_time = @interface.sleep_time
    LOGGER.info(PROC) { "Sleep DISABLED with rate of #{sleep_time} seconds" }
    true
  end

  # API

  def fuck_yeah!
    @bus_device.update(chars: "fuck yeah".bytes, ike: :set_ike, gfx: :radio_set)
  end

  def key
    @bus_device.state(key: :key_6, status: 0x04)
  end
end

module ClusterTools
  HUD_SIZE = 20

  LEFT = :ljust
  CENTERED = :center
  RIGHT = :rjust

  ALIGNMENTS = [LEFT, CENTERED, RIGHT].freeze

  def align(chars_string, alignment = CENTERED)
    raise ArgumentError, "Invalid alignment #{alignment}" unless ALIGNMENTS.include?(alignment)
    chars_string.public_send(alignment, HUD_SIZE)
  end

  def centered(chars_string, opts = { upcase: true })
    upcase = opts[:upcase]

    chars_string = chars_string.center(HUD_SIZE)
    chars_string = chars_string.upcase if upcase
    chars_string
  end

  def encoding
    (0..255).step(10) do |x|
      line = 20.times.map do |i|
        "#{(x+i).chr rescue 0}"
      end.join(' ')
      @bus_device.displays({ gfx: 0x40, ike: 0x30, chars: line }, 0xC8, 0x80 )
      Kernel.sleep(5)
    end
  end
end

module NameTools
  # Convert a symbol :name to instance variable name
  # @return [Instance Variable Name] :@variable_name
  def inst_var(name)
    name_string = name.id2name
    '@'.concat(name_string).to_sym
  end

  # Convert a symbol :name to class variable name
  # @return [Class Variable Name] :@@variable_name
  def class_var(name)
    name_string = name.id2name
    '@@'.concat(name_string).to_sym
  end

  # # Convert a symbol :name to class constant name
  # @return [Class Constant Name] :CONSTANT_NAME
  def class_const(name)
    name_string = name.upcase
    name_string.to_sym
  end
end

module Helpers
  include ModuleTools
  extend ModuleTools
  include NameTools
  include DeviceTools
end
