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
          byte_received(action, properties)
        when FRAME_RECEIVED
          frame_received(action, properties)
        when BUS_ONLINE
          bus_online(action, properties)
        when BUS_OFFLINE
          bus_offline(action, properties)
        when EXIT
          exit(action, properties)
        end
      rescue StandardError => e
        LOGGER.error(name) { e }
        e.backtrace.each { |l| LOGGER.error(l) }
      end

      private

      def byte_received(action, properties)
        @data_logging_handler.update(action, properties)
      end

      def frame_received(action, properties)
        @data_logging_handler.update(action, properties)
      end

      def bus_online(action, properties)
        LOGGER.info(name) { 'Bus Online!' }
        @data_logging_handler.update(action, properties)
      end

      def bus_offline(action, properties)
        # LOGGER.warn(name) { 'Bus Offline!' }
        @data_logging_handler.update(action, properties)
      end

      def exit(action, properties)
        LOGGER.debug(name) { "Delegate: #{@data_logging_handler.class}" }
        @data_logging_handler.update(action, properties)
        LOGGER.debug(name) { "Delegate: #{@data_logging_handler.class} complete!" }
      end
    end
  end
end
