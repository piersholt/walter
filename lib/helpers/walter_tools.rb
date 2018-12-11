# WalterTools
# Helpers for common tasks on CLI
module WalterTools
  PROC_MOD = 'WalterTools'.freeze
  include CommandTools

  def defaults
    LOGGER.info(PROC_MOD) { 'Applying debug defaults.' }
    shutup!
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

  def c
    DisplayHandler.i.clear_filter
  end

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

  def rad
    DisplayHandler.i.f_t(:rad, :bmbt)
    DisplayHandler.i.f_f(:rad, :bmbt)
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
