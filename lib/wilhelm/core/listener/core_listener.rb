# frozen_string_literal: true

module Wilhelm
  module Core
    # Comment
    class CoreListener < BaseListener
      attr_accessor :interface_handler, :data_logging_handler

      def initialize(interface_handler: nil, data_logging_handler: nil)
        @interface_handler = interface_handler
        @data_logging_handler = data_logging_handler
      end

      NAME = 'Core::CoreListener'

      def name
        NAME
      end

      def update(action, properties = {})
        case action
        when BYTE_RECEIVED
          data_logging_handler&.byte_received(properties)
        when FRAME_RECEIVED
          data_logging_handler&.frame_received(properties)
        when BUS_ONLINE
          data_logging_handler&.bus_online
        when BUS_OFFLINE
          data_logging_handler&.bus_offline
          interface_handler&.bus_offline
        end
      rescue StandardError => e
        LOGGER.error(name) { e }
        e.backtrace.each { |l| LOGGER.error(l) }
      end
    end
  end
end
