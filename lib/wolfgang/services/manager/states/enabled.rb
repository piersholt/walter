module Wolfgang
  class Manager
    class Enabled
      include Logger

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
    end
  end
end
