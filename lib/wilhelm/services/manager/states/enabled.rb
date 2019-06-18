module Wilhelm
  class Manager
    class Enabled
      include Constants
      include Defaults

      def initialize(context)
        logger.debug(MANAGER_ENABLED) { '#initialize' }
        # Note: this is a request
        context.devices?
      end

      # STATES --------------------------------------------------

      def disable(context)
        context.change_state(Disabled.new)
      end

      def on(context)
        context.change_state(On.new(context))
      end

      # Notifications ------------------------------------------------

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
