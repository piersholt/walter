module Wolfgang
  class Audio
    class On
      include Logger

      def initialize(context)
        logger.debug(AUDIO_ON) { '#initialize' }
        # Build state
        context.send_me_everyone
      end

      # STATES --------------------------------------------------

      def disable(context)
        context.change_state(Disabled.new)
      end

      # PLAYER ------------------------------------------------

      def everyone(context, properties)
        logger.info(AUDIO_ON) { ":everyone => #{properties}" }
        player_object = Player.new(properties)
        context.player.everyone!(player_object)
      end

      def track_change(context, properties)
        logger.info(AUDIO_ON) { ":track_change => #{properties}" }
        player_object = Player.new(properties)
        context.player.track_change!(player_object)
      end

      def track_start(context, properties)
        logger.info(AUDIO_ON) { ":track_start => #{properties}" }
        player_object = Player.new(properties)
        context.player.track_start!(player_object)
      end

      def track_end(context, properties)
        logger.info(AUDIO_ON) { ":track_end => #{properties}" }
        player_object = Player.new(properties)
        context.player.track_end!(player_object)
      end

      def position(context, properties)
        logger.info(AUDIO_ON) { ":position => #{properties}" }
        player_object = Player.new(properties)
        context.player.position!(player_object)
      end

      def status(context, properties)
        logger.info(AUDIO_ON) { ":status => #{properties}" }
        player_object = Player.new(properties)
        context.player.status!(player_object)
      end

      def repeat(context, properties)
        logger.info(AUDIO_ON) { ":repeat => #{properties}" }
        player_object = Player.new(properties)
        context.player.repeat!(player_object)
      end

      def shuffle(context, properties)
        logger.info(AUDIO_ON) { ":shuffle => #{properties}" }
        player_object = Player.new(properties)
        context.player.shuffle!(player_object)
      end

      # TARGET ------------------------------------------------

      def player_added(context, properties)
        logger.info(AUDIO_ON) { ":player_added => #{properties}" }
        # target_object = Target.new(properties)
        context.target.player_added(properties)
      end

      def player_changed(context, properties)
        logger.info(AUDIO_ON) { ":player_changed => #{properties}" }
        # target_object = Target.new(properties)
        context.target.player_changed(properties)
      end

      def player_removed(context, properties)
        logger.info(AUDIO_ON) { ":player_removed => #{properties}" }
        # target_object = Target.new(properties)
        context.target.player_removed(properties)
      end
    end
  end
end
