# frozen_string_literal: true

class Wilhelm::API
  class Controls
    class Control
      # A two stage control is best used when a control serves multiple
      # functions. Example: next track on press, and fast-forward track on
      # hold.
      class TwoStage < Base
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
