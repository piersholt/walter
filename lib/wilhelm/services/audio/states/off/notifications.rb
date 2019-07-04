# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Off
        # Audio::Off::Notifications
        module Notifications
          include Logging

          # TARGET

          def addressed_player(context, properties)
            logger.info(AUDIO_OFF) { ":addressed_player => #{properties}" }
            player_object = Player.new(properties)
            context.player.addressed_player!(player_object)
          end

          def player_added(context, properties)
            logger.info(AUDIO_OFF) { ":player_added => #{properties}" }
            context.target.player_added(properties)
          end

          def player_changed(context, properties)
            logger.info(AUDIO_OFF) { ":player_changed => #{properties}" }
            context.target.player_changed(properties)
          end

          def player_removed(context, properties)
            logger.info(AUDIO_OFF) { ":player_removed => #{properties}" }
            context.target.player_removed(properties)
            context.disable
          end
        end
      end
    end
  end
end
