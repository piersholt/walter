# frozen_string_literal: true

class Vehicle
  class Controls
    class Control
      # Comment
      class Strategy
        attr_reader :control_id
        def initialize(control_id)
          @control_id = control_id
        end

        def logger
          LogActually.controls
        end

        def upgrade
          false
        end
      end

      # Stateless controls will only notify on the press event. This is best
      # for when the assigned function has no state which can make no use of
      # the hold or release events. While the interval to the release event
      # is largely imperceptible, there's no point in incurring it.
      class Stateless < Strategy
        def notify(context)
          logger.debug(name) { '#notify(context)' }
          return false unless context.press?
          context.changed
          context.notify_observers(:button,
                                   control: context.button,
                                   state: :run)
        end

        def name
          "#{control_id}:Stateless"
        end

        def upgrade
          context.strategy = TwoStage.new(context.name)
        end
      end

      # Stateful controls will notify on the press and release events, which
      # suits stateful functions. Example: fast-forward track. Stateful
      # controls make no use of the hold event.
      class Stateful < Strategy
        def notify(context)
          logger.debug(name) { '#notify(context)' }
          return false if context.hold?
          context.changed
          context.notify_observers(:button,
                                   control: context.button,
                                   state: toggle_state(context))
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

      # A two stage control is best used when a control serves multiple
      # functions. Example: next track on press, and fast-forward track on
      # hold.
      class TwoStage < Strategy
        def notify(context)
          logger.debug(name) { '#notify(context)' }
          return false if context.press?
          if context.hold?
            on!
            notify_state = :on
          elsif context.release?
            notify_state = on? ? :off : :run
            off! if on?
          end

          context.changed
          context.notify_observers(:button,
                                   control: context.button,
                                   state: notify_state)
        end

        def upgrade
          false
        end

        def toggle
          @toggle ||= :off
        end

        def on?
          case toggle
          when :on
            true
          when :off
            false
          end
        end

        def on!
          @toggle = :on
        end

        def off!
          @toggle = :off
        end

        def name
          "#{control_id}:TwoStage"
        end
      end
    end
  end
end
