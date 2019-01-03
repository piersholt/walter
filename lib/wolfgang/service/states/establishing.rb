# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Service
    # Wolfgang Service Establishing State
    class Establishing
      include Logger

      def initialize
        logger.debug(self.class) { '#initialize' }
      end

      def open(___)
        logger.debug(self.class) { '#open' }
        false
      end

      # TODO: kill connection?
      def close(context)
        logger.debug(self.class) { '#close' }
        context.change_state(Offline.new)
      end

      def online!(context)
        context.change_state(Online.new)
        context.audio!
        context.notifications!
        context.alive?
      end

      def offline!(context)
        context.change_state(Offline.new)
      end
    end
  end
end
