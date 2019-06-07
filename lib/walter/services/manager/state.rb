# frozen_string_literal: true

class Walter
  class Manager
    # Comment
    module State
      include Constants
      
      def change_state(new_state)
        logger.info(MANAGER) { "state change => #{new_state.class}" }
        @state = new_state
        changed
        notify_observers(@state)
        @state
      end

      def enable
        @state.enable(self)
      end

      def disable
        @state.disable(self)
      end

      def on
        @state.on(self)
      end
    end
  end
end
