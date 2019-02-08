# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Service
    # Wolfgang Service Establishing State
    class Establishing
      include Logger

      def initialize
        logger.debug(WOLFGANG_EST) { '#initialize' }
      end

      def open(___)
        logger.debug(WOLFGANG_EST) { '#open' }
        false
      end

      def close(context)
        logger.debug(WOLFGANG_EST) { '#close' }
        logger.debug(WOLFGANG_EST) { 'Stop Notifications' }
        context.notifications&.stop
        logger.debug(WOLFGANG_EST) { 'Disable Mananger' }
        context.manager&.disable
        logger.debug(WOLFGANG_EST) { 'Disable Audio' }
        context.audio&.disable
        logger.debug(WOLFGANG_EST) { 'Disconnect Client.' }
        Client.disconnect
        context.offline!
      end

      def online!(context)
        context.change_state(Online.new)
        context.manager!
        context.audio!
        context.notifications!
        context.ui!
        context.alive?
      end

      def offline!(context)
        context.change_state(Offline.new)
      end

      def establishing!(context)
        return false
        context.change_state(Establishing.new)
      end
    end
  end
end
