# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      module Notifications
        # Manager::Notifications::DeviceHandler
        class DeviceHandler
          include Singleton
          include Yabber::NotificationDelegate
          include Yabber::Constants

          attr_accessor :context, :manager

          DEVICE_HANDLER = 'Handler::Device'

          def notification_delegate
            DEVICE_HANDLER
          end

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(DEVICE_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :connected
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(DEVICE_HANDLER) { ":device_connected => #{id}" }
              manager.devices.update(notification.properties, :connected)
            when :disconnected
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(DEVICE_HANDLER) { ":device_disconnected => #{id}" }
              manager.devices.update(notification.properties, :disconnected)
            when :connecting
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(DEVICE_HANDLER) { ":device_connecting => #{id}" }
              manager.devices.update(notification.properties, :connecting)
            when :disconnecting
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(DEVICE_HANDLER) { ":device_disconnecting => #{id}" }
              manager.devices.update(notification.properties, :disconnecting)
            when :new_device
              logger.info(DEVICE_HANDLER) { ':new_device' }
              logger.warn(DEVICE_HANDLER) { ':new_device => I don\'t like this notification....' }
              manager.new_device(notification.properties)
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
  end
end
