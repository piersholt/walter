# frozen_string_literal: true

module Wilhelm
  class Virtual
    module Listener
      # Comment
      class VirtualListener < Core::BaseHandler
        include LogActually::ErrorOutput

        attr_reader :message_handler
        attr_accessor :display_handler

        def update(action, properties)
          LogActually.virtual.debug(name) { "#update(#{action}, #{properties})" }
          case action
          when MESSAGE_RECEIVED
            display_handler&.message_received(properties)
            message_handler&.message_received(properties)
          when MESSAGE_SENT
            message_handler&.message_sent(properties)
          end
        rescue StandardError => e
          LogActually.virtual.error(name) { e }
          e.backtrace.each { |line| LogActually.virtual.error(line) }
        end

        def message_handler=(object)
          object.add_observer(self)
          @message_handler = object
        end
      end
    end
  end
end
