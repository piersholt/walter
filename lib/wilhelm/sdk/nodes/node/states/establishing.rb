# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Node
    # Wolfgang Service Establishing State
    class Establishing
      include Defaults
      include Constants
      include Logging

      def disconnect(context)
        logger.debug(NODE_EST) { '#close' }
        Client.disconnect
        context.offline!
      end

      alias close disconnect

      def online!(context)
        context.change_state(Online.new)
        context.alive?
      end

      def offline!(context)
        context.change_state(Offline.new)
      end

      def alive?(context)
        logger.debug(NODE_EST) { '#alive?' }
        context.ping!(context.ping_callback)
        true
      end

      def ping_callback(context)
        proc do |reply, error|
          begin
            if reply
              logger.info(NODE_EST) { 'Online!' }
              context.online!
            elsif error == :timeout
              logger.warn(NODE_EST) { 'Timeout!' }
              context.change_state(Establishing.new)
            elsif error == :down
              logger.warn(NODE_EST) { 'Error!' }
              context.change_state(Offline.new)
            end
          rescue StandardError => e
            logger.error(NODE_EST) { e }
            e.backtrace.each { |line| logger.error(NODE_EST) { line } }
            context.change_state(Offline.new)
          end
        end
      end
    end
  end
end
