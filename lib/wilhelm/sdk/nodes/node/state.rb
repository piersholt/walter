# frozen_string_literal: true

module Wilhelm
  class Node
    # Comment
    module State
      include Constants

      def change_state(new_state)
        logger.info(NODE) { "state change => #{new_state.class}" }
        @state = new_state
        changed
      notify_observers(state)
        @state
      end
    end
  end
end
