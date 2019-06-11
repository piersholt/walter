# frozen_string_literal: true

# Application Container
class Walter
  include Observable
  include DebugTools
  include ManageableThreads
  include Analyze
  include Shared

  attr_reader :bus, :wolfgang
  alias w wolfgang

  PROC = 'Walter'

  def initialize
    setup_core
    context = setup_virtual(interface: @interface,
                            multiplexer: @multiplexer,
                            demultiplexer: @demultiplexer)
    setup_api(context)
    setup_sdk

    # For exit event
    add_observer(global_listener)
    add_observer(data_logging_listener)
    add_observer(display_listener)

    apply_debug_defaults

    connection_options =
      { port: ENV['publisher_port'],
        host: ENV['publisher_host'] }
    LOGGER.warn(PROC) { "Publisher connection options: #{connection_options}" }
    Publisher.params(connection_options)
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
    @receiver.on
    @transmitter.on
    @demultiplexer.on
    @multiplexer.on

    @wolfgang.open
  end

  def stop
    LOGGER.debug(PROC) { '#stop' }

    LOGGER.info(PROC) { 'Switching off Wolfgang...' }
    @wolfgang.close
    LOGGER.info(PROC) { 'Wolfgang is off! 👍' }

    LOGGER.info(PROC) { 'Switching off Multiplexing...' }
    @demultiplexer.off
    @multiplexer.off
    LOGGER.info(PROC) { 'Multiplexing is off! 👍' }

    LOGGER.info(PROC) { 'Switching off Transceiver...' }
    @receiver.off
    @transmitter.off
    LOGGER.info(PROC) { 'Transceiver is off! 👍' }

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

  def setup_core
    # TODO: better argument handling to support multiple log files
    @interface   = Interface.new(ARGV.shift)

    @receiver    = Receiver.new(@interface.input_buffer)
    @transmitter = Transmitter.new(@interface.output_buffer)

    @demultiplexer =
      DataLink::LogicalLinkLayer::Demultiplexer
      .new(@receiver.frame_input_buffer)
    @multiplexer =
      DataLink::LogicalLinkLayer::Multiplexer
      .new(@transmitter.frame_output_buffer)

    interface_handler = DataLinkHandler.new(@transmitter)
    @data_link_listener = DataLinkListener.new(interface_handler)

    @interface.add_observer(global_listener)
    @interface.add_observer(@data_link_listener)
    @interface.add_observer(data_logging_listener)
    @interface.add_observer(session_listener)

    @receiver.add_observer(global_listener)
    @receiver.add_observer(data_logging_listener)
    @receiver.add_observer(session_listener)
  end

  def setup_virtual(interface:, multiplexer:, demultiplexer:)
    @bus =
      Virtual::Initialization
      .new(augmented: %i[gfx bmbt mfl], emulated: %i[rad tel])
      .execute

    bus_handler = BusHandler
                   .new(bus: bus,
                        packet_output_buffer:
                          multiplexer.packet_output_buffer)

    interface.add_observer(bus_handler)
    demultiplexer.add_observer(bus_handler)

    bus_handler.add_observer(global_listener)
    bus_handler.add_observer(display_listener)
    bus_handler.add_observer(session_listener)
    bus_handler.add_observer(bus_handler)

    bus.send_all(:add_observer, bus_handler)
    # bus.send_all(:add_observer, vehicle_display)
    bus
  end

  def setup_api(context)
    # Walter API
    vehicle_display = Vehicle::Display.instance
    vehicle_button = Vehicle::Controls.instance
    vehicle_audio = Vehicle::Audio.instance
    vehicle_telephone = Vehicle::Telephone.instance

    vehicle_display.bus = context
    vehicle_button.bus = context
    vehicle_audio.bus = context
    vehicle_telephone.bus = context

    vehicle_button.targets.each do |target|
      device = context.public_send(target)
      device.add_observer(vehicle_button)
    end

    vehicle_display.targets.each do |target|
      device = context.public_send(target)
      device.add_observer(vehicle_display)
    end
  end

  def setup_sdk
    @wolfgang = Wolfgang::ApplicationContext.new

    manager = Walter::Manager.new
    audio = Walter::Audio.new

    manager.disable
    audio.disable

    @wolfgang.register_service(:manager, manager)
    @wolfgang.register_service(:audio, audio)
  end
end
