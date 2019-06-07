# frozen_string_literal: true

module Wolfgang
  class Manager
    class On
      include Constants

      def initialize(context)
        logger.debug(MANAGER_ON) { '#initialize' }
      end

      # STATES --------------------------------------------------

      def disable(context)
        context.change_state(Disabled.new)
      end

      def on(context)
        false
      end

      # Commands ------------------------------------------------

      def connect_device(context, device_address)
        logger.info(MANAGER_ON) { ":connect_device => #{device_address}" }
        Vehicle::Telephone.instance.connect
        context.connect(device_address)
      end

      def disconnect_device(context, device_address)
        logger.info(MANAGER_ON) { ":disconnect_device => #{device_address}" }
        context.disconnect(device_address)
      end

      # Notifications ------------------------------------------------

      def new_device(context, properties)
        logger.info(MANAGER_ON) { ":device_found => #{properties['Name']}" }
        context.devices.update_device(properties)
      end

      def device_connected(context, properties)
        logger.info(MANAGER_ON) { ":device_connected => #{properties['Name']}" }
        Vehicle::Telephone.instance.connected
        context.devices.update_device(properties, :connected)
      end

      def device_disconnected(context, properties)
        logger.info(MANAGER_ON) { ":device_disconnected => #{properties['Name']}" }
        Vehicle::Telephone.instance.disconnected
        context.devices.update_device(properties, :disconnected)
      end

      def device_connecting(context, properties)
        device_id = properties['Name'] || 'Unknown Device'
        logger.info(MANAGER_ON) { ":device_connecting => #{device_id}" }
        Vehicle::Telephone.instance.connecting
        context.devices.update_device(properties, :connecting)
      end

      def device_disconnecting(context, properties)
        device_id = properties['Name'] || 'Unknown Device'
        logger.info(MANAGER_ON) { ":device_disconnecting => #{device_id}" }
        Vehicle::Telephone.instance.disconnecting
        context.devices.update_device(properties, :disconnecting)
      end
    end
  end
end
