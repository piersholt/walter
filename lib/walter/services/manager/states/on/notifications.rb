# frozen_string_literal: true

class Walter
  class Manager
    class On
      module Notifications
        include Constants

        def new_device(context, properties)
          logger.info(MANAGER_ON) { ":device_found => #{properties['Name']}" }
          context.devices.update_device(properties)
        end

        def device_connected(context, properties)
          logger.info(MANAGER_ON) { ":device_connected => #{properties['Name']}" }
          Wilhelm::API::Telephone.instance.connected
          context.devices.update_device(properties, :connected)
        end
        
        def device_disconnected(context, properties)
          logger.info(MANAGER_ON) { ":device_disconnected => #{properties['Name']}" }
          Wilhelm::API::Telephone.instance.disconnected
          context.devices.update_device(properties, :disconnected)
        end

        def device_connecting(context, properties)
          device_id = properties['Name'] || 'Unknown Device'
          logger.info(MANAGER_ON) { ":device_connecting => #{device_id}" }
          Wilhelm::API::Telephone.instance.connecting
          context.devices.update_device(properties, :connecting)
        end

        def device_disconnecting(context, properties)
          device_id = properties['Name'] || 'Unknown Device'
          logger.info(MANAGER_ON) { ":device_disconnecting => #{device_id}" }
          Wilhelm::API::Telephone.instance.disconnecting
          context.devices.update_device(properties, :disconnecting)
        end
      end
    end
  end
end
