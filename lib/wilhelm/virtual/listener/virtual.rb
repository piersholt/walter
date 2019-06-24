# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Listener
      # Comment
      class VirtualListener < Core::BaseHandler
        include LogActually::ErrorOutput

        attr_reader :message_handler
        attr_accessor :display_handler

        def name
          'Virtual::VirtualListener'
        end

        def session_handler
          @session_handler ||= Core::SessionHandler.instance
        end

        def update(action, properties)
          LOGGER.debug(name) { "#update(#{action}, #{properties})" }
          case action
          when MESSAGE_RECEIVED
            display_handler&.message_received(properties)
            message_handler&.message_received(properties)
            session_handler&.message_received(properties)
          when MESSAGE_SENT
            message_handler&.message_sent(properties)
          end
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(line) }
        end

        def message_handler=(object)
          object.add_observer(self)
          @message_handler = object
        end
      end
    end
  end
end
