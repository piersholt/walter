# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class Device
        # Manager::Device::Notifications
        module Notifications
          include Constants

          def pending?
            @pending ||= false
          end

          def connected
            @pending = false
            changed
            notify_observers(:connected, device: self)
          end

          def disconnected
            @pending = false
            changed
            notify_observers(:disconnected, device: self)
          end

          def connecting
            @pending = true
            changed
            notify_observers(:connecting, device: self)
          end

          def disconnecting
            @pending = true
            changed
            notify_observers(:disconnecting, device: self)
          end
        end
      end
    end
  end
end
