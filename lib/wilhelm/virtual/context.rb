# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Parent class
    class Context
      attr_reader :bus

      def initialize(application_object, core_context)
        @bus = setup_bus
        setup_event_handling(application_object, core_context)
        bus
      end

      def setup_bus
        Bus::Initialization
          .new(augmented: %i[gfx bmbt mfl ike lcm], emulated: %i[rad tel dsp tv ses dia])
          .execute
      end

      def setup_event_handling(application_object, core_context)
        core_listener = Listener::CoreListener.new
        virtual_listener = Listener::VirtualListener.new
        application_listener = Listener::ApplicationListener.new

        interface_handler = Handler::InterfaceHandler.new(bus)
        data_handler = Handler::DataHandler.new(bus, core_context.multiplexer.packet_output_buffer)
        display_handler = Handler::DisplayHandler.instance
        message_handler = Handler::MessageHandler.new(bus)

        core_listener.interface_handler = interface_handler
        core_listener.data_handler = data_handler

        virtual_listener.message_handler = message_handler
        virtual_listener.display_handler = display_handler

        application_listener.display_handler = display_handler

        core_context.interface.add_observer(core_listener)
        core_context.demultiplexer.add_observer(core_listener)
        application_object.add_observer(application_listener)

        # Convoluted: Listening for MESSAGE_RECEIVED
        core_listener.data_handler.add_observer(virtual_listener)
        # Convoluted: Listening for DATA_SENT
        virtual_listener.message_handler.add_observer(core_listener)

        # MESSAGE_RECEIVED
        # bus_handler.add_observer(session_listener)

        bus.send_all(:add_observer, virtual_listener)
        true
      end
    end
  end
end
