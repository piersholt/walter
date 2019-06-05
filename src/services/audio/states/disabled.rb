module Wolfgang
  class Audio
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

      # TARGET ------------------------------------------------

      def player_added(context, properties)
        logger.info(AUDIO_DISABLED) { ":player_added => #{properties}" }
        context.enable
        context.player_added(properties)
      end

      def player_removed(context, properties)
        logger.info(AUDIO_DISABLED) { ":player_removed => #{properties}" }
        # context.disable
        context.player_removed(properties)
      end
    end
  end
end
