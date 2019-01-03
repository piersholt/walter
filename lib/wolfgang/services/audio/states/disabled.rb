module Wolfgang
  class Audio
    class Disabled
      include Logger

      def enable(context)
        context.change_state(Enabled.new)
      end
    end
  end
end
