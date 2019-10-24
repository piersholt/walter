# frozen_string_literal: true

module Wilhelm
  module Services
    class Telephone
      # Telephone::Actions
      module Actions
        include Logging

        def volume_up
          logger.info(stateful) { '#volume_up()' }
          # @state.volume_up(self)
        end

        def volume_down
          logger.info(stateful) { '#volume_down()' }
          # @state.volume_down(self)
        end

        def mode_off
          logger.info(stateful) { '#mode_off()' }
          mode(false)
        end

        def mode_on
          logger.info(stateful) { '#mode_on()' }
          mode(true)
        end

        def backward(toggle)
          logger.info(stateful) { "#backward(#{toggle})" }
        end

        def forward(toggle)
          logger.info(stateful) { "#forward(#{toggle})" }
        end

        private

        def mode(state)
          logger.info(stateful) { "#mode(#{state})" }
          # @state.mode(self, state)
        end
      end
    end
  end
end
