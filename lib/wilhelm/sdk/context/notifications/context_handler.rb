# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class Notifications
        # Context::Notifications::ContextHandler
        class ContextHandler
          include Singleton
          include Yabber::NotificationDelegate
          include Yabber::Constants

          attr_accessor :context

          DEBUG_HANDLER = 'Handler::Debug'

          def notification_delegate
            DEBUG_HANDLER
          end

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(DEBUG_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :announcement
              logger.warn(DEBUG_HANDLER) { "Node accouncements are disabled!" }
              # context.announcement(notification.node)
            else
              not_handled(notification)
            end
          rescue StandardError => e
            logger.error(DEBUG_HANDLER) { e }
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
