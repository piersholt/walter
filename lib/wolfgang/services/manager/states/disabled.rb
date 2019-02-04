module Wolfgang
  class Manager
    class Disabled
      include Logger

      def enable(context)
        context.change_state(Enabled.new)
        context.on
      end

      def on(context)
        context.change_state(On.new(context))
        # logger.info(self.class) { "get device list!" }
        # context.device_list
        # context.device_list
      end
    end
  end
end
