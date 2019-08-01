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

        def pending
          @state.pending(self)
        end

        def off
          @state.off(self)
        rescue StandardError => e
          logger.error(self.class) { e }
          e.backtrace.each { |line| logger.error(self.class) { line } }
        end

        def on
          @state.on(self)
        rescue StandardError => e
          logger.error(self.class) { e }
          e.backtrace.each { |line| logger.error(self.class) { line } }
        end

        alias disable! disable
        alias pending! pending
        alias off! off
        alias on! on
      end
    end
  end
end
