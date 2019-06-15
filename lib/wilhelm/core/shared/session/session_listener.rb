# frozen_string_literal: true

module Wilhelm
  module Core
    # Comment
    class SessionListener < BaseListener
      # name = self.class.name

      def initialize(handlers = {})
        @session_handler = SessionHandler.instance
      end

      def name
        self.class.name
      end

      def update(action, properties = {})
        # LOGGER.unknown(name) { "#update(#{action}, #{properties})" }
        case action
        when BYTE_RECEIVED
          byte_received(action, properties)
        when FRAME_RECEIVED
          frame_received(action, properties)
        when FRAME_FAILED
          frame_failed(action, properties)
        when MESSAGE_RECEIVED
          message_received(action, properties)
        end
      rescue StandardError => e
        LOGGER.error(name) { e }
        e.backtrace.each { |l| LOGGER.error(l) }
      end

      private

      # ---- APPLICATION --- #

      def message_received(action, properties)
        @session_handler.update(action, properties)
      end

      # ---- DATALINK --- #

      def frame_received(action, properties)
        @session_handler.update(action, properties)
      end

      def frame_failed(action, properties)
        @session_handler.update(action, properties)
      end

      # ---- PHYSICAL --- #

      def byte_received(action, properties)
        @session_handler.update(action, properties)
      end
    end
  end
end
