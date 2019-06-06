module Wolfgang
  class Manager
    class Disabled
      include Constants
      include Defaults

      def enable(context)
        context.change_state(Enabled.new(context))
      end

      def disable(context)
        context.change_state(Disabled.new)
      end

      def on(context)
        context.change_state(On.new(context))
      end
    end
  end
end
