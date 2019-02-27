module Wolfgang
  class Audio
    class Enabled
      include Logger

      def initialize(context)
        logger.debug(AUDIO_ENABLED) { '#initialize' }
        context.player?
      end

      # STATES --------------------------------------------------

      def disable(context)
        context.change_state(Disabled.new)
      end

      def enable(context)
        context.change_state(Enabled.new(context))
      end

      def on(context)
        context.change_state(On.new(context))
      end

      # TARGET ------------------------------------------------

      def addressed_player(context, properties)
        logger.info(AUDIO_ENABLED) { ":addressed_player => #{properties}" }
        player_object = Player.new(properties)
        context.player.addressed_player!(player_object)
        context.on
        true
      end

      def player_added(context, properties)
        context.on
        context.target.player_added(properties)
        true
      end

      def player_removed(context, properties)
        # context.disable
        # context.target.player_removed(properties)
        false
      end

      # PLAYER ------

      def track_change(context, properties)
        false
      end

      def track_start(context, properties)
        false
      end

      def track_end(context, properties)
        false
      end

      def position(context, properties)
        false
      end

      def status(context, properties)
        false
      end

      def repeat(context, properties)
        false
      end

      def shuffle(context, properties)
        false
      end
    end
  end
end
