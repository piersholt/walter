# frozen_string_literal: true

module Wilhelm
  module Core
    # Comment
    class DataLinkListener < BaseListener
      def initialize(interface_handler)
        @interface_handler = interface_handler
      end

      def name
        self.class.name
      end

      def update(action, properties = {})
        # LogActually.datalink.unknown(name) { "#update(#{action}, #{properties})" }
        case action
        when BUS_OFFLINE
          bus_offline(action, properties)
        end
      rescue StandardError => e
        LogActually.datalink.error(name) { e }
        e.backtrace.each { |l| LogActually.datalink.error(l) }
      end

      private

      def bus_offline(action, properties)
        # LogActually.datalink.warn(name) { 'Bus Offline!' }
        @interface_handler.update(action, properties)
      end
    end
  end
end
