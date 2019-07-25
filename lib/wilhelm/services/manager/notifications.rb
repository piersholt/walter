# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Notifications
      module Notifications
        include Logging

        # Manager::Properties.setup_devices
        def devices_update(event, args = {})
          logger.info(stateful) { "#{event}!" }
          case event
          when :connected
            Wilhelm::API::Telephone.instance.connected
          when :disconnected
            Wilhelm::API::Telephone.instance.disconnected
          when :connecting
            Wilhelm::API::Telephone.instance.connecting
          when :disconnecting
            Wilhelm::API::Telephone.instance.disconnecting
          end
        end
      end
    end
  end
end
