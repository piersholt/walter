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

          DEVICE_HANDLER = 'Manager'

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(DEVICE_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :announce
              logger.warn(DEVICE_HANDLER) { ':announcement disabled!' }
              # manager.enable
            when :device_connecting
              logger.info(DEVICE_HANDLER) { "#{:device_connecting}" }
              manager.device_connecting(notification.properties)
            when :device_connected
              logger.info(DEVICE_HANDLER) { "#{:device_connected}" }
              manager.device_connected(notification.properties)
            when :device_disconnecting
              logger.info(DEVICE_HANDLER) { "#{:device_disconnecting}" }
              manager.device_disconnecting(notification.properties)
            when :device_disconnected
              logger.info(DEVICE_HANDLER) { "#{:device_disconnected}" }
              manager.device_disconnected(notification.properties)
            when :new_device
              logger.info(DEVICE_HANDLER) { "#{:new_device}" }
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
