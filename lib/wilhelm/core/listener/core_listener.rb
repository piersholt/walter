# frozen_string_literal: true

module Wilhelm
  module Core
    module Listener
      # Comment
      class CoreListener < BaseListener
        attr_accessor :interface_handler

        def initialize(interface_handler: nil)
          @interface_handler = interface_handler
        end

        NAME = 'Core::CoreListener'

        def name
          NAME
        end

        def update(action, ___ = {})
          case action
          when FRAME_RECEIVED
            false
          when BUS_ONLINE
            false
          when BUS_OFFLINE
            interface_handler&.bus_offline
          end
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |l| LOGGER.error(l) }
        end
      end
    end
  end
end
