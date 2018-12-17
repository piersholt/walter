# WalterTools
# Helpers for common tasks on CLI
module WalterTools
  PROC_MOD = 'WalterTools'.freeze
  include CommandGroups

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

  def dia
    DisplayHandler.i.hide_commands(*KEEP_ALIVE, *SPEED, *TEMPERATURE, *IGNITION, *COUNTRY, *LAMP)
  end

  def diag
    DisplayHandler.i.filter_commands(*CommandGroups::DIA)
  end

  def obc
    DisplayHandler.i.filter_commands(*CommandGroups::OBC)
  end

  def ping
    DisplayHandler.i.filter_commands(*CommandGroups::KEEP_ALIVE)
  end

  def shutup!
    DisplayHandler.i.shutup!
  end

  def ign
    DisplayHandler.i.filter_commands(*CommandGroups::IGNITION)
  end

  def rad
    DisplayHandler.i.f_t(:rad, :bmbt)
    DisplayHandler.i.f_f(:rad, :bmbt)
  end

  def tel
    DisplayHandler.i.f_t(* DeviceGroups::TELEPHONE + DeviceGroups::BROADCAST)
    DisplayHandler.i.f_f(*DeviceGroups::TELEPHONE)
    DisplayHandler.i.h_c(* SPEED + TEMPERATURE + COUNTRY + VEHICLE + LAMP + IKE_SENSOR + OBC + KEEP_ALIVE + IGNITION + [CommandAliases::HUD_TEXT] )
    DisplayHandler.i.h_c(* [CommandAliases::RAD_LED, CommandAliases::SRC_CTL, CommandAliases::SND_SRC, CommandAliases::RAD_CONFIG, CommandAliases::RAD_STATUS])
  end

  def cd
    DisplayHandler.i.f_t(* DeviceGroups::CD)
    DisplayHandler.i.f_f(* DeviceGroups::CD)
    DisplayHandler.i.h_c(* SPEED + TEMPERATURE + COUNTRY + VEHICLE + LAMP + IKE_SENSOR + OBC + IGNITION + [CommandAliases::HUD_TEXT] )
    DisplayHandler.i.h_c(* [])
  end

  def media
    DisplayHandler.i.f_t(* DeviceGroups::MEDIA + BROADCAST )
    DisplayHandler.i.f_f(*DeviceGroups::MEDIA)
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

  def nap(seconds)
    # @interface.read_thread[:sleep_time] = seconds
    @interface.read_thread.thread_variable_set(:sleep_time, seconds)
  end

  def sleepy?
    # @interface.read_thread[:sleep_enabled] = false
    @interface.read_thread.thread_variable_get(:sleep_enabled)
  end

  def awake!
    t = @interface.read_thread
    # @interface.read_thread[:sleep_enabled] = false
    t.thread_variable_set(:sleep_enabled, false)
    # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
  end

  def sleepy!
    t = @interface.read_thread
    # @interface.read_thread[:sleep_enabled] = true
    t.thread_variable_set(:sleep_enabled, true)
    # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
  end

  # API

  def fuck_yeah!
    @bus_device.update(chars: "fuck yeah".bytes, ike: :set_ike, gfx: :radio_set)
  end

  def key
    @bus_device.state(key: :key_6, status: 0x04)
  end
end
