# frozen_string_literal: true

# Top level namespace
module Wilhelm
  module SDK
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
          LOGGER.debug(NODE_ONLINE) { "#alive? (#{self.class}, #{LOGGER.id})" }
          context.ping!(context.ping_callback)
          true
        end

        def ping_callback(context)
          proc do |reply, error|
            begin
              if reply
                LOGGER.debug(NODE_ONLINE) { "Alive! (#{self.class}, #{LOGGER.id})" }
                Thread.new(context) do
                  begin
                    Kernel.sleep(PING_INTERVAL)
                    context.alive?
                  rescue StandardError => e
                    LOGGER.error(NODE_ONLINE) { e }
                    e.backtrace.each { |line| LOGGER.error(NODE_ONLINE) { line } }
                  end
                end
              elsif error == :timeout
                LOGGER.warn(NODE_ONLINE) { "Timeout!" }
                context.establishing!
              elsif error == :down
                LOGGER.warn(NODE_ONLINE) { "Error!" }
                context.offline!
              end
            rescue MessagingQueue::GoHomeNow => e
              # LOGGER.fatal(NODE_ONLINE) { 'Doing many, many important things!' }
              # with_backtrace(LOGGER., e)
              # LOGGER.fatal(NODE_ONLINE) { 'Okay bye now!' }
              raise e
            rescue StandardError => e
              LOGGER.error(NODE_ONLINE) { e }
              e.backtrace.each { |line| LOGGER.error(NODE_ONLINE) { line } }
              context.offline!
            end
          end
        end
      end
    end
  end
end
