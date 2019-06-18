# frozen_string_literal: false

module Wilhelm
  class Audio
    # Comment
    class On
      include Constants
      include Defaults

      def initialize(___)
        logger.debug(AUDIO_ON) { '#initialize' }
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

      # USER CONTROL

      def volume_up(context)
        context.target.volume_up
      end

      def volume_down(context)
        context.target.volume_down
      end

      def power(context)
        result = context.player.power
        logger.info(AUDIO_ON) { "#power() => #{result}" }
        if result
          Wilhelm::API::Audio.instance.on
        else
          Wilhelm::API::Audio.instance.off
        end
        result
      end

      def pause(context)
        result = context.player.pause
        logger.info(AUDIO_ON) { "#pause() => #{result}" }
        result
      end

      def seek_forward(context)
        logger.info(AUDIO_ON) { "#seek_forward()" }
        context.player.seek_forward
      end

      def seek_backward(context)
        logger.info(AUDIO_ON) { "#seek_backward()" }
        context.player.seek_backward
      end

      def scan_forward(context, toggle)
        logger.debug(AUDIO) { "#scan_forward(#{toggle})" }
        case toggle
        when :on
          context.player.scan_forward_start
        when :off
          context.player.scan_forward_stop
        end
      end

      def scan_backward(context, toggle)
        logger.debug(AUDIO) { "#scan_back(#{toggle})" }
        case toggle
        when :on
          context.player.scan_backward_start
        when :off
          context.player.scan_backward_stop
        end
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

      def addressed_player(context, properties)
        logger.info(AUDIO_ON) { ":addressed_player => #{properties}" }
        player_object = Player.new(properties)
        context.player.addressed_player!(player_object)
      end

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
        context.disable
      end
    end
  end
end
