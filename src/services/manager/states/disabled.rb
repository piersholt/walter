module Wolfgang
  class Manager
    class Disabled
      include Constants

      def enable(context)
        context.change_state(Enabled.new(context))
      end

      def on(context)
        context.change_state(On.new(context))
      end
    end
  end
end
