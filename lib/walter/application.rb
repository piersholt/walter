# frozen_string_literal: true

# Application Container
class Walter
  include Observable
  include Wilhelm::Virtual::Helpers::Console
  include ManageableThreads
  include Wilhelm::Core::Analyze
  include Shared
  include Wilhelm::Core::Constants::Events::Application

  attr_reader :bus, :wolfgang
  alias w wolfgang

  PROC = 'Walter'

  def initialize(file:, console:)
    @console = console

    @core = setup_core(file)
    context = setup_virtual(interface: @core.interface,
                            multiplexer: @core.multiplexer,
                            demultiplexer: @core.demultiplexer)
    setup_api(context)
    setup_sdk

    # For exit event
    add_observer(data_logging_listener)

    apply_debug_defaults

    connection_options =
      { port: ENV['publisher_port'],
        host: ENV['publisher_host'] }
    LOGGER.debug(PROC) { "Publisher connection options: #{connection_options}" }
    Publisher.params(connection_options)
  end

  def launch
    LOGGER.debug(PROC) { '#launch' }
    Thread.current[:name] = 'Walter (Main)'
    begin
      start
      raise NotImplementedError, 'Pry Console' if @console

      LOGGER.debug 'Main Thread / Entering keep alive loop...'
      loop do
        news
        sleep 120
      end
    rescue NotImplementedError
      LOGGER.info(PROC) { 'Console start.' }
      binding.pry
      LOGGER.info(PROC) { 'Console end.' }
    rescue Interrupt
      LOGGER.debug 'Interrupt signal caught.'
    ensure
      LOGGER.info(PROC) { "Walter is closing!" }

      LOGGER.info(PROC) { "Publishing event: #{EXIT}" }
      changed
      notify_observers(EXIT, {reason: 'bin'})
      LOGGER.info(PROC) { "Subscribers updated! #{EXIT}" }

      LOGGER.info(PROC) { "Turning stack off ⛔️" }
      stop
      LOGGER.info(PROC) { "Stack is off 👍" }

      LOGGER.info(PROC) { "See you anon ✌️" }
    end
  end

  def start
    LOGGER.debug(PROC) { '#start' }
    @core.on
  end

  def stop
    LOGGER.debug(PROC) { '#stop' }
    LOGGER.info(PROC) { 'Switching off Wilhelm...' }
    @wolfgang.close
    LOGGER.info(PROC) { 'Wilhelm is off! 👍' }
    @core.off
  end

  private

  def setup_core(file)
    core = Wilhelm::Core::Context.new(file)
    core.interface.add_observer(data_logging_listener)
    core.receiver.add_observer(data_logging_listener)
    core
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
    virtual_listener.display_handler = Wilhelm::Virtual::Handler::DisplayHandler.instance

    application_listener = Wilhelm::Virtual::Listener::ApplicationListener.new
    application_listener.display_handler = Wilhelm::Virtual::Handler::DisplayHandler.instance
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

    core_listener = Wilhelm::SDK::Listener::CoreListener.new
    interface_handler = Wilhelm::SDK::Handler::InterfaceHandler.new(@wolfgang)
    core_listener.interface_handler = interface_handler
    @core.interface.add_observer(core_listener)

    manager = Wilhelm::Services::Manager.new
    audio = Wilhelm::Services::Audio.new

    manager.disable
    audio.disable

    @wolfgang.register_service(:manager, manager)
    @wolfgang.register_service(:audio, audio)
  end
end
