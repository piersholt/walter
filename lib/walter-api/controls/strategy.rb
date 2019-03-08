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

      # Comment
      class Stateless < Strategy
        def notify(context)
          logger.debug(name) { "#notify(context)" }
          return false unless context.press?
          context.changed
          context.notify_observers(:button,
                                   button: context.button,
                                   state: :run)
        end

        def name
          "#{control_id}:Stateless"
        end

        def upgrade
          context.strategy = TwoStage.new(context.name)
        end
      end

      # Comment
      class Stateful < Strategy
        def notify(context)
          logger.debug(name) { "#notify(context)" }
          return false if context.hold?
          context.changed
          context.notify_observers(:button,
                                   button: context.button,
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

      # Comment
      class TwoStage < Strategy
        def notify(context)
          logger.debug(name) { "#notify(context)" }
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
                                   button: context.button,
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
