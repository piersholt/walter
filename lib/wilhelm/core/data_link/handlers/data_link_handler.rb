# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class DataLinkHandler < BaseHandler
      def initialize(transitter)
        @transmitter = transitter
      end

      def self.i
        instance
      end

      def name
        self.class.name
      end

      def update(action, properties)
        # LOGGER.debug(name) { "\t#update(#{action}, #{properties})" }
        case action
        when BUS_OFFLINE
          bus_offline
        end
      rescue StandardError => e
        LOGGER.error(name) { e }
        e.backtrace.each { |line| LOGGER.error(line) }
      end

      private

      def bus_offline
        LOGGER.warn(name) { 'Bus Offline! Disabling transmission.' }
        disable_transitter
      end

      def disable_transitter
        @transmitter.disable
      end
    end
  end
end
