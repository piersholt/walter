# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Off
        module Notifications
          # Audio::Off::Notifications::Player
          module Player
            include Logging

            def player_properties_changed(context, properties)
              logger.info(AUDIO_OFF) { ":player_properties_changed => #{properties}" }
              context.player.changed!(properties)
            end
          end
        end
      end
    end
  end
end
