# frozen_string_literal: true

module Wilhelm
  module API
    class Controls
      class Control
        # Stateless controls will only notify on the press event. This is best
        # for when the assigned function has no state which can make no use of
        # the hold or release events. While the interval to the release event
        # is largely imperceptible, there's no point in incurring it.
        class Stateless < Base
          def notify(context)
            logger.debug(name) { '#notify(context)' }
            return false unless context.press?
            context.changed
            context.notify_observers(
              :control,
              control: context.button,
              state: :run
            )
          end

          def name
            "#{control_id}:Stateless"
          end

          def upgrade
            context.strategy = TwoStage.new(context.name)
          end
        end
      end
    end
  end
end
