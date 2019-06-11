# frozen_string_literal: true

# Top level namespace
module Wilhelm
  class Node
    # Wilhelm Service Online State
    class Online
      include Defaults
      include Constants
      include Logging

      def establishing!(context)
        context.change_state(Establishing.new)
        context.alive?
      end

      def offline!(context)
        context.change_state(Offline.new)
      end

      def alive?(context)
        LogActually.alive.debug(NODE_ONLINE) { "#alive? (#{self.class}, #{LogActually.alive.id})" }
        context.ping!(context.ping_callback)
        true
      end

      def ping_callback(context)
        proc do |reply, error|
          begin
            if reply
              LogActually.alive.debug(NODE_ONLINE) { "Alive! (#{self.class}, #{LogActually.alive.id})" }
              Thread.new(context) do
                begin
                  Kernel.sleep(PING_INTERVAL)
                  context.alive?
                rescue StandardError => e
                  LogActually.node.error(NODE_ONLINE) { e }
                  e.backtrace.each { |line| LogActually.node.error(NODE_ONLINE) { line } }
                end
              end
            elsif error == :timeout
              LogActually.alive.warn(NODE_ONLINE) { "Timeout!" }
              context.establishing!
            elsif error == :down
              LogActually.alive.warn(NODE_ONLINE) { "Error!" }
              context.offline!
            end
          rescue MessagingQueue::GoHomeNow => e
            # LogActually.alive.fatal(NODE_ONLINE) { 'Doing many, many important things!' }
            # with_backtrace(LogActually.alive., e)
            # LogActually.alive.fatal(NODE_ONLINE) { 'Okay bye now!' }
            raise e
          rescue StandardError => e
            LogActually.node.error(NODE_ONLINE) { e }
            e.backtrace.each { |line| LogActually.node.error(NODE_ONLINE) { line } }
            context.offline!
          end
        end
      end
    end
  end
end
