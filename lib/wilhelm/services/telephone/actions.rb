# frozen_string_literal: true

module Wilhelm
  module Services
    class Telephone
      # Telephone::Actions
      module Actions
        include Logging
        # include Yabber::API

        def volume_up
          logger.debug(stateful) { '#volume_up()' }
          @state.volume_up(self)
        end

        def volume_down
          logger.debug(stateful) { '#volume_down()' }
          @state.volume_down(self)
        end

        def mode_off
          logger.debug(stateful) { '#mode_off()' }
          mode(false)
        end

        def mode_on
          logger.debug(stateful) { '#mode_on()' }
          mode(true)
        end

        def mode(state)
          logger.debug(stateful) { "#mode(#{state})" }
          @state.mode(self, state)
        end
      end
    end
  end
end
