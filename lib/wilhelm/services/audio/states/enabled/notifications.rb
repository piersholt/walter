# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Enabled
        # Audio::Enabled::Notifications
        module Notifications
          include Logging

          # TARGET

          def addressed_player(context, properties)
            logger.info(AUDIO_ENABLED) { ":addressed_player => #{properties}" }
            player_object = Player.new(properties)
            context.player.addressed_player!(player_object)
            context.off
            true
          end

          def player_added(context, properties)
            logger.info(AUDIO_ENABLED) { ":player_added => #{properties}" }
            context.target.player_added(properties)
            context.off
            true
          end
        end
      end
    end
  end
end
