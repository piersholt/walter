# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class DeviceHandler
      include Singleton
      include NotificationDelegate
      include Messaging::Constants

      attr_accessor :bus

      def logger
        LogActually.messaging
      end

      def take_responsibility(notification)
        logger.debug(self.class) { "#take_responsibility(#{notification})" }
        case notification.name
        when CONNECTING
          bus.tel.bluetooth_connecting
        when CONNECTED
          bus.tel.bluetooth_connected
        when DISCONNECTING
          bus.tel.bluetooth_disconnecting
        when DISCONNECTED
          bus.tel.bluetooth_disconnected
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each { |l| logger.error(l) }
      end

      def responsibility
        MANAGER
      end
    end
  end
end
