# frozen_string_literal: true

module Wilhelm
  module Core
    # Comment
    class CoreListener < BaseListener
      attr_accessor :interface_handler

      def initialize(interface_handler)
        @interface_handler = interface_handler
      end

      NAME = 'Core::CoreListener'

      def name
        NAME
      end

      def update(action, properties = {})
        case action
        when BUS_OFFLINE
          interface_handler&.bus_offline
        end
      rescue StandardError => e
        LogActually.datalink.error(name) { e }
        e.backtrace.each { |l| LogActually.datalink.error(l) }
      end
    end
  end
end
