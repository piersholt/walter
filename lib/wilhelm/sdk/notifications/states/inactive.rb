# frozen_string_literal: true

# Comment
module Wilhelm
  module SDK
    class Notifications
      class Inactive
        include Constants
        def start(notifications_context)
          logger.debug(NOTIFICATIONS_INACTIVE) { '#start' }
          setup_incoming_notifications_handlers(notifications_context)
          notifications_context.change_state(Active.new)
        rescue StandardError => e
          with_backtrace(logger, e)
        end

        def stop(notifications_context)
          logger.debug(NOTIFICATIONS_INACTIVE) { '#stop' }
          false
        end

        def setup_incoming_notifications_handlers(notifications_context)
          primary = configure_incomining_notifications_delegates(notifications_context)
          notification_listener = Listener.instance
          notification_listener.declare_primary_delegate(primary)
          notification_listener.listen
        rescue StandardError => e
          with_backtrace(logger, e)
        end

        def configure_incomining_notifications_delegates(notifications_context)
          debug_handler     = DebugHandler.instance
          debug_handler.context = notifications_context.wolfgang_context

          notifications_context
          .registered_handlers
          .inject(debug_handler) do |memo, object|
            memo.successor = object
            object
          end

          notifications_context.registered_handlers.clear

          # controller_handler.successor = target_handler
          # target_handler.successor = device_handler
          # device_handler.successor = debug_handler
          debug_handler
        rescue StandardError => e
          with_backtrace(logger, e)
        end
      end
    end
  end
end
