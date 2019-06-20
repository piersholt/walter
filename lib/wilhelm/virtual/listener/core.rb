# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Listener
      # Comment
      class CoreListener < Core::BaseHandler
        include LogActually::ErrorOutput

        attr_accessor :packet_handler, :interface_handler

        def name
          'Virtual::CoreListener'
        end

        def update(action, properties)
          LOGGER.debug(name) { "#update(#{action}, #{properties})" }
          case action
          when PACKET_RECEIVED
            packet_handler&.packet_received(properties)
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
