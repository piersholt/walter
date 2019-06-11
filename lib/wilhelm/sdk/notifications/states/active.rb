# frozen_string_literal: true

# Comment
module Wilhelm
  class Notifications
    class Active
      include Constants
      def start(context)
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
