# frozen_string_literal: true

module Wilhelm
  module Core
    # Comment
    class DataLoggingListener < BaseListener
      def initialize(data_logging_handler = DataLoggingHandler.instance)
        @data_logging_handler = data_logging_handler
      end

      NAME = 'DataLogging'

      def name
        NAME
      end

      def update(action, properties = {})
        case action
        when BYTE_RECEIVED
          @data_logging_handler.update(action, properties)
        when FRAME_RECEIVED
          @data_logging_handler.update(action, properties)
        when BUS_ONLINE
          @data_logging_handler.update(action, properties)
        when BUS_OFFLINE
          @data_logging_handler.update(action, properties)
        when EXIT
          exit(action, properties)
        end
      rescue StandardError => e
        LOGGER.error(name) { e }
        e.backtrace.each { |l| LOGGER.error(l) }
      end

      private

      def exit(action, properties)
        LOGGER.debug(name) { "Delegate: #{@data_logging_handler.class}" }
        @data_logging_handler.update(action, properties)
        LOGGER.debug(name) { "Delegate: #{@data_logging_handler.class} complete!" }
      end
    end
  end
end
