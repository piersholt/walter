# WalterTools
# Helpers for common tasks on CLI
module WalterTools
  PROC_MOD = 'WalterTools'.freeze
  include CommandGroups

  # Defaults

  def defaults
    LOGGER.info(PROC_MOD) { 'Applying debug defaults.' }
    # shutup!
    cdc
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

  def shutup!
    DisplayHandler.i.shutup!
  end

  def touch!
    DisplayHandler.i.h_c(*BUTTON)
  end

  alias shh! shutup!

  def ready
    DisplayHandler.i.filter_commands(*READY)
  end

  def diag
    DisplayHandler.i.filter_commands(*DIAGNOSTICS)
  end

  def obc
    DisplayHandler.i.filter_commands(*OBC)
  end

  def ign
    DisplayHandler.i.filter_commands(*IGNITION)
  end

  def tel
    DisplayHandler.i.f_t(*DeviceGroups::TELEPHONE + DeviceGroups::BROADCAST)
    DisplayHandler.i.f_f(*DeviceGroups::TELEPHONE)
    DisplayHandler.i.h_c(
      *SPEED, *TEMPERATURE, *COUNTRY, *VEHICLE, *LAMP,
      *SENSORS, *OBC, *READY, *IGNITION
    )
    DisplayHandler.i.h_c(RAD_LED, SRC_CTL, SND_SRC, MENU_GFX, MENU_RAD)
  end

  def nav
    DisplayHandler.i.f_t(*DeviceGroups::NAV)
    DisplayHandler.i.f_f(*DeviceGroups::NAV)
    DisplayHandler.i.h_c(
      *SPEED, *TEMPERATURE, *VEHICLE, *LAMP,
      *SENSORS, *OBC, *IGNITION
    )
  end

  def cdc
    DisplayHandler.i.f_t(*DeviceGroups::CD)
    DisplayHandler.i.f_f(*DeviceGroups::CD)
    DisplayHandler.i.h_c(
      *READY, *SPEED, *TEMPERATURE, *COUNTRY,
      *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
    )
  end

  def cdc!
    DisplayHandler.i.f_t(*DeviceGroups::CD)
    DisplayHandler.i.f_f(*DeviceGroups::CD)
    DisplayHandler.i.h_c(
      *READY, *SPEED, *TEMPERATURE, *COUNTRY,
      *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
    )

    DisplayHandler.i.h_c(*DISPLAY, *BUTTON)
  end

  def media
    DisplayHandler.i.f_t(*DeviceGroups::MEDIA + BROADCAST)
    DisplayHandler.i.f_f(*DeviceGroups::MEDIA)
  end

  # Logging

  # def debug
  #   LOGGER.sev_threshold=(Logger::DEBUG)
  # end
  #
  # def info
  #   LOGGER.sev_threshold=(Logger::INFO)
  # end

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
