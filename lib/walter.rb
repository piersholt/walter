# core dependencies
require 'observer'
require 'thread'

# external dependencies
require 'serialport'
require 'pry'

# local dependencies
require 'physical/byte'
require 'physical/byte_basic'
require 'physical/bytes'
require 'application/message'

require 'physical/interface'
require 'datalink/receiver'
require 'datalink/transmitter'
require 'listeners/global_listener'

require 'shared/shared'

require 'application/virtual/api/alive'
require 'application/virtual/api/radio_led'
require 'application/virtual/api/cd'
require 'application/virtual/api/media'
require 'application/virtual/api/telephone'
require 'application/virtual/virtual'

require 'io/notifications/notifications'

require 'helpers'

# Container
class Walter
  include Observable
  include WalterTools
  include ManageableThreads

  attr_reader :bus

  PROC = 'Walter'.freeze

  def handlers
    @handlers ||= {}
  end

  def initialize
    # TODO: better argument handling to support multiple log files
    @interface   = Interface.new(ARGV.shift)

    @receiver    = Receiver.new(@interface.input_buffer)
    @transmitter = Transmitter.new(@interface.output_buffer)

    handlers[:interface] = InterfaceHandler.new(@transmitter)
    handlers[:frame] = FrameHandler.new(@transmitter.write_queue)


    @bus         = Virtual::Initialization.new(augmented: [:rad], simulated: [:tel]).execute
    handlers[:bus] = BusHandler.new(bus: @bus)

    @session_listener = SessionListener.new
    @interface.add_observer(@session_listener)
    @receiver.add_observer(@session_listener)

    handlers[:intent] = IntentListener.instance

    @listener = GlobalListener.new(handlers)
    @interface.add_observer(@listener)

    @receiver.add_observer(@listener)


    @bus.send_all(:add_observer, @listener)
    @bus.send_all(:add_observer, @session_listener)
    add_observer(@listener)


    # require 'bus_device'
    # @bus_device = BusDevice.new
    # @bus_device.add_observer(@listener)

    Notifications.start(@bus)

    defaults
  end

  def launch
    LOGGER.debug(PROC) { '#launch' }
    Thread.current[:name] = 'Walter (Main)'
    begin
      start
      # TODO: menu to facilitate common features...
      raise NotImplementedError, 'menu not implemented. fallback to CLI...'

      LOGGER.debug "Main Thread / Entering keep alive loop..."
      loop do
        news
        sleep 60
      end

      # TODO: menu to facilitate common features...
      # raise NotImplementedError, 'menu not implemented. fallback to CLI...'
    rescue NotImplementedError
      rescue_not_implemented
    rescue Interrupt
      rescue_interrupt
    end
  end

  def start
    LOGGER.debug(PROC) { '#start' }
    @interface.on
    @receiver.on
    @transmitter.on
  end

  def stop
    LOGGER.debug(PROC) { '#stop' }

    LOGGER.info(PROC) { 'Switching off Receiver...' }
    @receiver.off
    LOGGER.info(PROC) { 'Receiver is off! 👍' }

    LOGGER.info(PROC) { 'Switching off Interface...' }
    @interface.off
    LOGGER.info(PROC) { 'Interface is off! 👍' }
  end

  private

  def rescue_interrupt
    LOGGER.debug 'Interrupt signal caught.'
    binding.pry
    changed
    notify_observers(Event::EXIT, {reason: 'Interrupt!'})
    stop
    return 1
  end

  def rescue_not_implemented
    LOGGER.info(PROC) { 'fallback CLI' }

    binding.pry

    LOGGER.info(PROC) { "Walter is closing!" }

    LOGGER.info(PROC) { "Publishing event: #{Event::EXIT}" }
    changed
    notify_observers(Event::EXIT, {reason: 'Debug exiting'})
    LOGGER.info(PROC) { "Subscribers updated! #{Event::EXIT}" }

    LOGGER.info(PROC) { "Turning stack off ⛔️" }
    stop
    LOGGER.info(PROC) { "Stack is off 👍" }

    LOGGER.info(PROC) { "See you anon ✌️" }
    return -1
  end
end
