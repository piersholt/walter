# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Devices
      class Devices < Collection
        include Constants

        PROG = 'Manager::Devices'

        # SCOPE

        def connected?
          values.find_all(&:connected?).count
        end

        def connected
          values.find_all(&:connected?)
        end

        def disconnected
          values.find_all(&:disconnected?)
        end

        # HANDLER

        def update(device_attributes_hash, notification = nil)
          device = create_or_update(device_attributes_hash)
          device.public_send(notification) if notification
        rescue StandardError => e
          logger.error(PROG) { e }
          e.backtrace.each { |line| logger.error(PROG) { line } }
        end

        # @todo Manager should handle collection events
        # Observable.notify
        def device_update(notification, device:)
          logger.debug(PROG) { "#device_update(#{device})" }
          case notification
          when :connected
            logger.info(PROG) { "Device: #{notification}: #{device.id}" }
            if connected.count == 1
              changed
              notify_observers(:connected, device: device)
            end
          when :disconnected
            logger.info(PROG) { "Device: #{notification}: #{device.id}" }
            if connected.count.zero?
              changed
              notify_observers(:disconnected, device: device)
            end
          when :connecting
            logger.info(PROG) { "Device: #{notification}: #{device.id}" }
            changed
            notify_observers(:connecting, device: device)
          when :disconnecting
            logger.info(PROG) { "Device: #{notification}: #{device.id}" }
            changed
            notify_observers(:disconnecting, device: device)
          else
            logger.warn(PROG) { "Device unknown: #{notification}!" }
          end
        end

        # COLLECTION

        def update_method
          :device_update
        end

        def klass
          Device
        end

        # @deprecated
        # Currently only called by Manager::Replies
        # def update_devices(devices_enum, notification = nil)
        #   logger.warn(PROG) { 'Deprecated! #update_devices' }
        #   return false
        #   devices_enum.each do |a_device|
        #     update_device(a_device, notification)
        #   end
        # end
      end
    end
  end
end
