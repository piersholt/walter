# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Off
        module Notifications
          # Audio::Off::Notifications::Target
          module Target
            include Logging

            def player_added(context, properties)
              logger.info(AUDIO_OFF) { ":player_added => #{properties}" }
              context.target.player_added(properties)
              true
            end

            def player_changed(context, properties)
              logger.info(AUDIO_OFF) { ":player_changed => #{properties}" }
              context.target.player_changed(properties)
              true
            end

            def player_removed(context, properties)
              logger.info(AUDIO_OFF) { ":player_removed => #{properties}" }
              context.target.player_removed(properties)
              context.disable
              true
            end
          end
        end
      end
    end
  end
end
