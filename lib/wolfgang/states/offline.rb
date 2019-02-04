# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Service
    # Wolfgang Service Offline State
    class Offline
      include Logger

      def initialize
        logger.debug(WOLFGANG_OFFLINE) { '#initialize' }
      end

      def open(context)
        logger.debug(WOLFGANG_OFFLINE) { '#open' }
        queue_alive(context)
        context.change_state(Establishing.new)
        true
      end

      def close(___)
        logger.debug(WOLFGANG_OFFLINE) { '#open' }
        return false
      end

      private

      def queue_alive(context)
        logger.debug(WOLFGANG_OFFLINE) { '#queue_alive' }
        # Client.instance.queue_message('ping', reply_block(context))
        context.ping!(reply_block(context))
        true
      end

      def alive?(context)
        logger.debug(WOLFGANG_ONLINE) { '#alive?' }
        # Client.instance.queue_message('ping', )
        context.ping!(alive_block(context))
        true
      end

      def reply_block(context)
        proc do |reply, error|
          begin
            if reply
              logger.info(WOLFGANG_OFFLINE) { 'Online!' }
              context.online!
            else
              logger.warn(WOLFGANG_OFFLINE) { "Error! (#{error})" }
              context.offline!
            end
          rescue StandardError => e
            logger.error(WOLFGANG_OFFLINE) { e }
            e.backtrace.each { |line| logger.error(WOLFGANG_OFFLINE) { line } }
            context.change_state(Offline.new)
          end
        end
      end
    end
  end
end
