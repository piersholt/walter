# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::State
      module State
        include Logging

        def change_state(new_state)
          logger.debug(MANAGER) { "State => #{new_state.class}" }
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
end
