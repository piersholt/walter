# frozen_string_literal: true

# Application Container
class Walter
  include Observable
  include Wilhelm::Core::Debug
  include ManageableThreads
  include Wilhelm::Core::Analyze
  include Shared
  include Wilhelm::Core::Constants::Events::Application

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
    add_observer(data_logging_listener)

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

    LOGGER.info(PROC) { 'Switching off Wilhelm...' }
    @wolfgang.close
    LOGGER.info(PROC) { 'Wilhelm is off! 👍' }

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
    notify_observers(EXIT, {reason: 'Interrupt!'})
    stop
    return 1
  end

  def rescue_not_implemented
    LOGGER.info(PROC) { 'fallback CLI' }

    binding.pry

    LOGGER.info(PROC) { "Walter is closing!" }

    LOGGER.info(PROC) { "Publishing event: #{EXIT}" }
    changed
    notify_observers(EXIT, {reason: 'Debug exiting'})
    LOGGER.info(PROC) { "Subscribers updated! #{EXIT}" }

    LOGGER.info(PROC) { "Turning stack off ⛔️" }
    stop
    LOGGER.info(PROC) { "Stack is off 👍" }

    LOGGER.info(PROC) { "See you anon ✌️" }
    return -1
  end

  def setup_core
    # TODO: better argument handling to support multiple log files
    @interface   = Wilhelm::Core::Interface.new(ARGV.shift)

    @receiver    = Wilhelm::Core::Receiver.new(@interface.input_buffer)
    @transmitter = Wilhelm::Core::Transmitter.new(@interface.output_buffer)

    @demultiplexer =
      Wilhelm::Core::DataLink::LogicalLinkLayer::Demultiplexer
      .new(@receiver.frame_input_buffer)
    @multiplexer =
      Wilhelm::Core::DataLink::LogicalLinkLayer::Multiplexer
      .new(@transmitter.frame_output_buffer)

    interface_handler = Wilhelm::Core::DataLinkHandler.new(@transmitter)
    @data_link_listener = Wilhelm::Core::DataLinkListener.new(interface_handler)

    @interface.add_observer(@data_link_listener)
    @interface.add_observer(data_logging_listener)
    # BYTE_RECEIVED
    # @interface.add_observer(session_listener)

    @receiver.add_observer(data_logging_listener)
    # FRAME_RECEIVED
    # @receiver.add_observer(session_listener)
  end

  def setup_virtual(interface:, multiplexer:, demultiplexer:)
    @bus =
      Wilhelm::Virtual::Initialization
      .new(augmented: %i[gfx bmbt mfl], emulated: %i[rad tel])
      .execute

    core_listener = Wilhelm::Virtual::Listener::CoreListener.new
    core_listener.packet_handler = Wilhelm::Virtual::Handler::PacketHandler.new(bus)
    core_listener.interface_handler = Wilhelm::Virtual::Handler::InterfaceHandler.new(bus)

    interface.add_observer(core_listener)
    demultiplexer.add_observer(core_listener)

    virtual_listener = Wilhelm::Virtual::Listener::VirtualListener.new
    virtual_listener.message_handler = Wilhelm::Virtual::Handler::MessageHandler.new(bus, multiplexer.packet_output_buffer)
    virtual_listener.display_handler = Wilhelm::Core::DisplayHandler.instance

    application_listener = Wilhelm::Virtual::Listener::ApplicationListener.new
    application_listener.display_handler = Wilhelm::Core::DisplayHandler.instance
    add_observer(application_listener)

    # Convoluted: Listening for MESSAGE_RECEIVED
    core_listener.packet_handler.add_observer(virtual_listener)

    # MESSAGE_RECEIVED
    # bus_handler.add_observer(session_listener)

    # bus.send_all(:add_observer, vehicle_display)
    bus.send_all(:add_observer, virtual_listener)
    bus
  end

  def setup_api(context)
    # Walter API
    vehicle_display = Wilhelm::API::Display.instance
    vehicle_button = Wilhelm::API::Controls.instance
    vehicle_audio = Wilhelm::API::Audio.instance
    vehicle_telephone = Wilhelm::API::Telephone.instance

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
    @wolfgang = Wilhelm::SDK::ApplicationContext.new

    manager = Walter::Manager.new
    audio = Walter::Audio.new

    manager.disable
    audio.disable

    @wolfgang.register_service(:manager, manager)
    @wolfgang.register_service(:audio, audio)
  end
end
