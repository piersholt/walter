# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Services::Audio::Constants
      module Constants
        AUDIO = 'Audio'

        AUDIO_STATE_DISABLED = 'Disabled'
        AUDIO_STATE_ENABLED  = 'Pending'
        AUDIO_STATE_OFF      = 'Off'
        AUDIO_STATE_ON       = 'On'

        AUDIO_DISABLED = "Audio (#{AUDIO_STATE_DISABLED})"
        AUDIO_ENABLED  = "Audio (#{AUDIO_STATE_ENABLED})"
        AUDIO_OFF      = "Audio (#{AUDIO_STATE_OFF})"
        AUDIO_ON       = "Audio (#{AUDIO_STATE_ON})"

        AUDIO_CONTROLS = 'Audio Controls'
      end
    end
  end
end
