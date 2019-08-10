# frozen_string_literal: true

module Wilhelm
  module SDK
    module Listener
      # SDK::Listener::CoreListener
      class CoreListener < Core::BaseHandler
        include LogActually::ErrorOutput

        attr_accessor :interface_handler

        NAME = 'SDK::CoreListener'.freeze

        def name
          NAME
        end

        def update(action, properties)
          LOGGER.debug(name) { "#update(#{action}, #{properties})" }
          case action
          when BUS_ONLINE
            interface_handler&.bus_online
          when BUS_OFFLINE
            interface_handler&.bus_offline
          end
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(line) }
        end
      end
    end
  end
end
