# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Disabled
        # Audio::Disabled::Notifications
        module Notifications
          include Logging

          def player_added(context, properties)
            logger.info(AUDIO_DISABLED) { ":player_added => #{properties}" }
            context.enable
            context.player_added(properties)
          end
        end
      end
    end
  end
end
