# frozen_string_literal: false

module Wilhelm
  module Core
    # Parent class
    class Context
      attr_reader :interface, :receiver, :transmitter, :multiplexer, :demultiplexer

      def initialize(path)
        setup_interface(path)
        setup_transceiver(@interface.input_buffer, @interface.output_buffer)
        setup_multiplexing(@receiver.frame_input_buffer, @transmitter.frame_output_buffer)
        setup_event_handling
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
        @interface = Interface.new(path)
      end

      def setup_transceiver(input_buffer, output_buffer)
        @receiver    = Receiver.new(input_buffer)
        @transmitter = Transmitter.new(output_buffer)
      end

      def setup_multiplexing(input_buffer, output_buffer)
        @demultiplexer = DataLink::LogicalLinkLayer::Demultiplexer.new(input_buffer)
        @multiplexer = DataLink::LogicalLinkLayer::Multiplexer.new(output_buffer)
      end

      def setup_event_handling
        core_listener = CoreListener.new(InterfaceHandler.new(@transmitter))
        @interface.add_observer(core_listener)
      end
    end
  end
end
