class Walter
  class Audio
    class Enabled
      include Constants
      include Defaults

      def initialize(context)
        logger.debug(AUDIO_ENABLED) { '#initialize' }
        # Note: this is a request
        context.player?
        # Wilhelm::API::Controls.instance.add_observer(context, :buttons_update)
        context.register_controls(Wilhelm::API::Controls.instance)
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
    end
  end
end
