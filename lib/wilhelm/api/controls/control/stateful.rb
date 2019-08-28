# frozen_string_literal: true

module Wilhelm
  module API
    class Controls
      class Control
        # Stateful controls will notify on the press and release events, which
        # suits stateful functions. Example: fast-forward track. Stateful
        # controls make no use of the hold event.
        class Stateful < Base
          def notify(context)
            logger.debug(name) { '#notify(context)' }
            return false if context.hold?
            context.changed
            context.notify_observers(
              :control,
              control: context.button,
              state: toggle_state(context)
            )
          end

          def toggle_state(context)
            case context.state
            when :press
              :on
            when :release
              :off
            end
          end

          def name
            "#{control_id}:Stateful"
          end

          def upgrade
            context.strategy = TwoStage.new(context.name)
          end
        end
      end
    end
  end
end
