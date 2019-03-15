module Wolfgang
  class Manager
    class Enabled
      include Constants

      def initialize(context)
        logger.debug(MANAGER_ENABLED) { '#initialize' }
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
        context.devices.update_device(properties, :connected)
      end

      def device_disconnected(context, properties)
        logger.info(MANAGER_ENABLED) { ":device_disconnected => #{properties['Name']}" }
        context.devices.update_device(properties, :disconnected)
      end
    end
  end
end
