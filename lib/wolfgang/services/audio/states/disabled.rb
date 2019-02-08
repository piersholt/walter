module Wolfgang
  class Audio
    class Disabled
      include Logger

      def enable(context)
        context.change_state(Enabled.new(context))
      end

      def disable(context)
        context.change_state(Disabled.new)
      end

      def on(context)
        context.change_state(On.new(context))
      end

      # def player(context)
      #
      # end

      # TARGET ------------------------------------------------

      def player_added(context, properties)
        logger.info(AUDIO_ENABLED) { ":player_added => #{properties}" }
        context.on
        context.player_added(properties)
      end

      def player_removed(context, properties)
        logger.info(AUDIO_ENABLED) { ":player_removed => #{properties}" }
        context.disable
        context.player_removed(properties)
      end
    end
  end
end
