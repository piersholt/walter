# frozen_string_literal: true

# Comment
module Wilhelm
  module SDK
    class Notifications
      include LogActually::ErrorOutput
      attr_accessor :listener, :handler, :context
      attr_writer :bus
      alias wolfgang_context context

      include Constants

      def initialize(wolfgang_context)
        @context = wolfgang_context
        @state = Inactive.new
      end

      def bus
        context.bus
      end

      def start
        logger.debug(NOTIFICATIONS) { '#start' }
        @state.start(self)
      end

      def stop
        logger.debug(NOTIFICATIONS) { '#stop' }
        @state.stop(self)
      end

      def change_state(new_state)
        logger.debug(NOTIFICATIONS) { "State => #{new_state.class}" }
        @state = new_state
      end

      def registered_handlers
        @registered_handlers ||= []
      end

      def register_handlers(*handlers)
        logger.debug(NOTIFICATIONS) { "#register_handlers(#{handlers})" }
        handlers.each do |handler|
          registered_handlers << handler
        end
      end
    end
  end
end
