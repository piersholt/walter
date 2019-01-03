# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Service
    # Wolfgang Service Offline State
    class Offline
      include Logger

      def initialize
        logger.debug(self.class) { '#initialize' }
      end

      def open(context)
        logger.debug(self.class) { '#open' }
        Client.pi
        Client.instance.queue_message('ping', reply_block(context))
        context.change_state(Establishing.new)
        true
      end

      private

      def reply_block(context)
        proc do |reply, error|
          begin
            if reply
              logger.info(self.class) { 'Online!' }
              context.online!
            else
              logger.warn(self.class) { 'Error!' }
              context.offline!
            end
          rescue StandardError => e
            logger.error(self.class) { e }
            e.backtrace.each { |line| logger.error(self.class) { line } }
            context.change_state(Offline.new)
          end
        end
      end
    end
  end
end
