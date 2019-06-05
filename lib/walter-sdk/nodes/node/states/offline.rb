# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Node
    # Wolfgang Service Offline State
    class Offline
      include Defaults
      include Constants
      include Logging

      def connect(context)
        logger.debug(NODE_OFFLINE) { '#connect' }
        context.change_state(Establishing.new)
        alive?(context)
        true
      end

      alias open connect

      def online!(context)
        context.change_state(Online.new)
      end

      def establishing!(context)
        context.change_state(Establishing.new)
        context.alive?
      end

      def alive?(context)
        logger.debug(NODE_OFFLINE) { '#alive?' }
        context.ping!(context.ping_callback)
        true
      end

      def ping_callback(context)
        proc do |reply, error|
          begin
            if reply
              logger.info(NODE_OFFLINE) { 'Online!' }
              context.online!
            elsif error == :timeout
              logger.warn(NODE_OFFLINE) { 'Timeout!' }
              context.change_state(Establishing.new)
            elsif error == :down
              logger.warn(NODE_OFFLINE) { 'Error!' }
              context.change_state(Offline.new)
            end
          rescue StandardError => e
            logger.error(NODE_OFFLINE) { e }
            e.backtrace.each { |line| logger.error(NODE_OFFLINE) { line } }
            context.change_state(Offline.new)
          end
        end
      end
    end
  end
end
