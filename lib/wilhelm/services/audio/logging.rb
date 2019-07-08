# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Logging
      module Logging
        include Constants
        include LogActually::ErrorOutput

        def to_s
          "Audio (#{state_string})"
        end

        def nickname
          :audio
        end

        def state_string
          case state
          when Disabled
            AUDIO_STATE_DISABLED
          when Enabled
            AUDIO_STATE_ENABLED
          when Off
            AUDIO_STATE_OFF
          when On
            AUDIO_STATE_ON
          else
            state.class
          end
        end

        def logger
          LOGGER
        end
      end
    end
  end
end
