# frozen_string_literal: true

# Top level namespace
module Wilhelm
  # Default Wilhelm logger
  module Constants
    include LogActually::ErrorOutput

    AUDIO = 'Audio'
    AUDIO_CONTROLS = 'Audio Controls'
    AUDIO_DISABLED = 'Audio (Disabled)'
    AUDIO_ENABLED = 'Audio (Enabled)'
    AUDIO_ON = 'Audio (On)'

    # AUDIO_INDEX = 'Audio INDEX'
    # AUDIO_NP = 'Audio NP'

    def logger
      LogActually.context
    end
  end
end
