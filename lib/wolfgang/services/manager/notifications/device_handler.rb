# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class DeviceHandler
      include Singleton
      include NotificationDelegate
      include Messaging::Constants

      attr_accessor :context

      def logger
        LogActually.messaging
      end

      def take_responsibility(notification)
        logger.debug(self.class) { "#take_responsibility(#{notification})" }
        case notification.name
        when :device_connecting
          logger.info(self.class) { "#{:device_connecting}" }
          context.manager.device_connecting(notification.properties)
          # context.bus.tel.bluetooth_connecting
        when :device_connected
          logger.info(self.class) { "#{:device_connected}" }
          context.manager.device_connected(notification.properties)
          # context.bus.tel.bluetooth_connected
        when :device_disconnecting
          logger.info(self.class) { "#{:device_disconnecting}" }
          context.manager.device_disconnecting(notification.properties)
          # context.bus.tel.bluetooth_disconnecting
        when :device_disconnected
          logger.info(self.class) { "#{:device_disconnected}" }
          context.manager.device_disconnected(notification.properties)
          # context.bus.tel.bluetooth_disconnected
        when :new_device
          logger.info(self.class) { "#{:new_device}" }
          context.manager.new_device(notification.properties)
          # context.bus.tel.bluetooth_disconnected
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
