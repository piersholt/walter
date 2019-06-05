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

      DEVICE_HANDLER = 'Manager'

      def logger
        LogActually.notify
      end

      def take_responsibility(notification)
        logger.debug(DEVICE_HANDLER) { "#take_responsibility(#{notification})" }
        case notification.name
        when :announce
          logger.info(DEVICE_HANDLER) { "#{:announcement}" }
          context.manager.enable
        when :device_connecting
          logger.info(DEVICE_HANDLER) { "#{:device_connecting}" }
          context.manager.device_connecting(notification.properties)
          # context.bus.tel.bluetooth_connecting
        when :device_connected
          logger.info(DEVICE_HANDLER) { "#{:device_connected}" }
          context.manager.device_connected(notification.properties)
          # context.bus.tel.bluetooth_connected
        when :device_disconnecting
          logger.info(DEVICE_HANDLER) { "#{:device_disconnecting}" }
          context.manager.device_disconnecting(notification.properties)
          # context.bus.tel.bluetooth_disconnecting
        when :device_disconnected
          logger.info(DEVICE_HANDLER) { "#{:device_disconnected}" }
          context.manager.device_disconnected(notification.properties)
          # context.bus.tel.bluetooth_disconnected
        when :new_device
          logger.info(DEVICE_HANDLER) { "#{:new_device}" }
          context.manager.new_device(notification.properties)
          # context.bus.tel.bluetooth_disconnected
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(DEVICE_HANDLER) { e }
        e.backtrace.each { |l| logger.error(l) }
      end

      def responsibility
        DEVICE
      end
    end
  end
end
