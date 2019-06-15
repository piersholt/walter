# frozen_string_literal: true

# Application Container
class Wernher
  include Observable
  include Wilhelm::Core::DebugTools
  include ManageableThreads
  include Analyze
  include Shared

  PROC = 'Walter'

  def initialize
    setup_core

    # For exit event
    add_observer(data_logging_listener)
    add_observer(display_listener)
  end

  def launch
    LOGGER.debug(PROC) { '#launch' }
    Thread.current[:name] = 'Walter (Main)'
    begin
      start
      # TODO: menu to facilitate common features...
      raise NotImplementedError, 'menu not implemented. fallback to CLI...'

      LOGGER.debug 'Main Thread / Entering keep alive loop...'
      loop do
        news
        sleep 120
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
    # @receiver.on
  end

  def stop
    LOGGER.debug(PROC) { '#stop' }

    # LOGGER.info(PROC) { 'Switching off Transceiver...' }
    # @receiver.off
    # LOGGER.info(PROC) { 'Transceiver is off! 👍' }

    LOGGER.info(PROC) { 'Switching off Interface...' }
    @interface.off
    LOGGER.info(PROC) { 'Interface is off! 👍' }
  end

  def upp
    SessionHandler.instance.up
  end

  def bytes
    SessionHandler.instance.bytes
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

  def setup_core
    # TODO: better argument handling to support multiple log files
    @interface   = Interface.new(ARGV.shift, Interface::UART::FBVZ_TTY_OPTIONS)
    @receiver    = Receiver.new(@interface.input_buffer, FBZV::Frame::Synchronisation)

    # @interface.add_observer(global_listener)
    @interface.add_observer(data_logging_listener)
    @interface.add_observer(session_listener)

    # @receiver.add_observer(global_listener)
    @receiver.add_observer(data_logging_listener)
    @receiver.add_observer(session_listener)
  end
end
