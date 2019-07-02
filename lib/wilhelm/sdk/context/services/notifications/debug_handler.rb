# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        class Notifications
          # Context::Services::Notifications::DebugHandler
          class DebugHandler
            include Singleton
            include NotificationDelegate
            include Messaging::Constants

            attr_accessor :context

            NODE_HANDLER = 'Nodes'

            def logger
              LOGGER
            end

            def take_responsibility(notification)
              logger.debug(NODE_HANDLER) { "#take_responsibility(#{notification})" }
              case notification.name
              when :announcement
                logger.warn(NODE_HANDLER) { "Node accouncements are disabled!" }
                # context.announcement(notification.node)
              else
                not_handled(notification)
              end
            rescue StandardError => e
              logger.error(NODE_HANDLER) { e }
              e.backtrace.each { |l| logger.error(l) }
            end

            def responsibility
              NODE
            end
          end
        end
      end
    end
  end
end
