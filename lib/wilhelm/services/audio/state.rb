# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::State
      module State
        include Logging

        attr_reader :state

        def change_state(new_state)
          logger.debug(AUDIO) { "State => #{new_state.class}" }
          @state = new_state
          changed
          notify_observers(@state)
          @state
        end

        def disable
          @state.disable(self)
        end

        def enable
          @state.enable(self)
        end

        def off
          @state.off(self)
        end

        def on
          @state.on(self)
        end
      end
    end
  end
end
