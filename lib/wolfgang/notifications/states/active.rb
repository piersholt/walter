# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    class Active
      include Logger
      def start(context)
        logger.debug(self.class) { '#start' }
        false
      end

      def stop(context)
        logger.debug(self.class) { '#stop' }
        context.change_state(Inactive.new)
      end
    end
  end
end
