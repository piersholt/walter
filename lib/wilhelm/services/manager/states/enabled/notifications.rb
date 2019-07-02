# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      class Enabled
        # Manager::Enabled::Notifications
        module Notifications
          include Logging

          def device_connected(context, properties)
            logger.info(MANAGER_ENABLED) { ":device_connected => #{properties['Name']}" }
            Wilhelm::API::Telephone.instance.connected
            context.devices.update_device(properties, :connected)
          end

          def device_disconnected(context, properties)
            logger.info(MANAGER_ENABLED) { ":device_disconnected => #{properties['Name']}" }
            Wilhelm::API::Telephone.instance.disconnected
            context.devices.update_device(properties, :disconnected)
          end
        end
      end
    end
  end
end
