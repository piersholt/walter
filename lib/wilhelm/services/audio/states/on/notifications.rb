# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class On
        # Audio::On::Notifications
        module Notifications
          include Logging

          # PLAYER

          def everyone(context, properties)
            logger.warn(AUDIO_ON) { '#everyone is deprecated!' }
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

          # TARGET

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
  end
end
