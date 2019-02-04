module Wolfgang
  class Audio
    class On
      include Logger

      def initialize(context)
        # Thread.new(context) do |cont|
        #   Kernel.sleep(3)
        #   cont.send_me_everyone
        # end
      end

      # PLAYER ------------------------------------------------

      def everyone(context, properties)
        logger.info(self.class) { ":everyone => #{properties}" }
        player_object = Player.new(properties)
        context.player.everyone!(player_object)
      end

      def track_change(context, properties)
        logger.info(self.class) { ":track_change => #{properties}" }
        player_object = Player.new(properties)
        context.player.track_change!(player_object)
      end

      def track_start(context, properties)
        logger.info(self.class) { ":track_start => #{properties}" }
        player_object = Player.new(properties)
        context.player.track_start!(player_object)
      end

      def track_end(context, properties)
        logger.info(self.class) { ":track_end => #{properties}" }
        player_object = Player.new(properties)
        context.player.track_end!(player_object)
      end

      def position(context, properties)
        logger.info(self.class) { ":position => #{properties}" }
        player_object = Player.new(properties)
        context.player.position!(player_object)
      end

      def status(context, properties)
        logger.info(self.class) { ":status => #{properties}" }
        player_object = Player.new(properties)
        context.player.status!(player_object)
      end

      def repeat(context, properties)
        logger.info(self.class) { ":repeat => #{properties}" }
        player_object = Player.new(properties)
        context.player.repeat!(player_object)
      end

      def shuffle(context, properties)
        logger.info(self.class) { ":shuffle => #{properties}" }
        player_object = Player.new(properties)
        context.player.shuffle!(player_object)
      end

      # TARGET ------------------------------------------------

      def player_added(context, properties)
        logger.info(self.class) { ":player_added => #{properties}" }
        # target_object = Target.new(properties)
        context.target.player_added(properties)
      end

      def player_changed(context, properties)
        logger.info(self.class) { ":player_changed => #{properties}" }
        # target_object = Target.new(properties)
        context.target.player_changed(properties)
      end

      def player_removed(context, properties)
        logger.info(self.class) { ":player_removed => #{properties}" }
        # target_object = Target.new(properties)
        context.target.player_removed(properties)
      end
    end
  end
end
