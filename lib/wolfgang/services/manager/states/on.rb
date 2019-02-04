module Wolfgang
  class Manager
    class On
      include Logger

      def initialize(context)
        # logger.info(self.class) { "#initialize: get devices!" }
        # context.device_list
      end

      # Commands ------------------------------------------------

      def connect_device(context, device_address)
        logger.info(self.class) { ":connect_device => #{device_address}" }
        context.connect(device_address)
      end

      def disconnect_device(context, device_address)
        logger.info(self.class) { ":disconnect_device => #{device_address}" }
        context.disconnect(device_address)
      end

      # Notifications ------------------------------------------------

      def new_device(context, properties)
        logger.info(self.class) { ":device_found => #{properties['Name']}" }
        context.devices.update_device(properties)
      end

      def device_connected(context, properties)
        logger.info(self.class) { ":device_connected => #{properties['Name']}" }
        context.devices.update_device(properties, :connected)
      end

      def device_disconnected(context, properties)
        logger.info(self.class) { ":device_disconnected => #{properties['Name']}" }
        context.devices.update_device(properties, :disconnected)
      end

      def device_connecting(context, properties)
        device_id = properties['Name'] || 'Unknown Device'
        logger.info(self.class) { ":device_connecting => #{device_id}" }
        context.devices.update_device(properties, :connecting)
      end

      def device_disconnecting(context, properties)
        device_id = properties['Name'] || 'Unknown Device'
        logger.info(self.class) { ":device_disconnecting => #{device_id}" }
        context.devices.update_device(properties, :disconnecting)
      end
    end
  end
end
