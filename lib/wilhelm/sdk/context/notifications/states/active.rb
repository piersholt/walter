# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class Notifications
        # Context::Notifications::Active
        class Active
          include Constants

          def start(*)
            logger.debug(NOTIFICATIONS_ACTIVE) { '#start' }
            false
          end

          def stop(context)
            logger.debug(NOTIFICATIONS_ACTIVE) { '#stop' }
            Listener.instance.stop
            context.change_state(Inactive.new)
          end
        end
      end
    end
  end
end
