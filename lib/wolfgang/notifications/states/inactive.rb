# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    class Inactive
      include Logger
      def start(context)
        logger.debug(self.class) { '#start' }
        setup_incoming_notifications_handlers(context.bus)
        context.change_state(Active.new)
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def stop(context)
        logger.debug(self.class) { '#stop' }
        false
      end

      def setup_incoming_notifications_handlers(bus)
        primary = configure_incomining_notifications_delegates(bus)
        notification_listener = Listener.instance
        notification_listener.declare_primary_delegate(primary)
        notification_listener.listen
      end

      def configure_incomining_notifications_delegates(bus)
        device_handler = DeviceHandler.instance
        controller_handler = ControllerHandler.instance

        device_handler.bus = bus
        controller_handler.bus = bus

        controller_handler.successor = device_handler
        controller_handler
      end
    end
  end
end
