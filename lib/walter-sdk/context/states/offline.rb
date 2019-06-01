# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class ApplicationContext
    # Wolfgang Service Offline State
    class Offline
      include Defaults
      include Constants

      def initialize(___ = nil)
        logger.debug(WOLFGANG_OFFLINE) { '#initialize' }
      end

      def open(context)
        logger.debug(WOLFGANG_OFFLINE) { '#open' }
        queue_alive(context)
        context.change_state(Establishing.new(context))
        true
      end

      def close(___)
        logger.debug(WOLFGANG_OFFLINE) { '#open' }
        return false
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
        false
        # context.change_state(Offline.new)
      end

      def establishing!(context)
        false
        # context.change_state(Offline.new)
      end

      private

      def queue_alive(context)
        logger.debug(WOLFGANG_OFFLINE) { '#queue_alive' }
        # Client.instance.queue_message('ping', reply_block(context))
        context.ping!(context.reply_block(context))
        true
      end

      def alive?(context)
        LogActually.alive.debug(WOLFGANG_ONLINE) { '#alive?' }
        # Client.instance.queue_message('ping', )
        context.ping!(context.reply_block(context))
        true
      end
    end
  end
end
