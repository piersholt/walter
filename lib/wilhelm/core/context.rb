# frozen_string_literal: false

module Wilhelm
  module Core
    # Parent class
    class Context
      attr_reader :interface, :receiver, :transmitter, :multiplexer, :demultiplexer

      def initialize(application_object, path)
        setup_interface(path)
        setup_transceiver(interface)
        setup_multiplexing(@receiver.output_buffer, @transmitter.frame_output_buffer)
        setup_event_handling(application_object)
      end

      def on
        @interface.on
        @receiver.on
        @transmitter.on
        @demultiplexer.on
        @multiplexer.on
      end

      def off
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

      def setup_interface(path)
        stream = Interface::Stat.new(path)
        stream_handler = stream.handler
        @interface = stream_handler.new(path)
      end

      def setup_transceiver(io_buffer)
        @receiver    = DataLink::Receiver.new(io_buffer)
        @transmitter = DataLink::Transmitter.new(io_buffer)
      end

      def setup_multiplexing(input_buffer, output_buffer)
        @demultiplexer = DataLink::Demultiplexer.new(input_buffer)
        @multiplexer = DataLink::Multiplexer.new(output_buffer)
      end

      def setup_event_handling(application_object)
        core_listener = Listener::CoreListener.new
        application_listener = Listener::ApplicationListener.new

        core_listener.interface_handler = InterfaceHandler.new(@transmitter)

        @interface.add_observer(core_listener)
        @receiver.add_observer(core_listener)
        application_object.add_observer(application_listener)
      end
    end
  end
end
