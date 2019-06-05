# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Default Wolfgang logger
  module Constants
    include LogActually::ErrorOutput

    WOLFGANG = 'Wolfgang'
    WOLFGANG_OFFLINE = 'Wolfgang (Offline)'
    WOLFGANG_EST = 'Wolfgang (Est.)'
    WOLFGANG_ONLINE = 'Wolfgang (Online)'

    PING_INTERVAL = 30

    # MANAGER = 'Mananger'
    # MANAGER_ENABLED = 'Mananger (Enabled)'
    # MANAGER_ON = 'Mananger (On)'
    #
    # AUDIO = 'Audio'
    # AUDIO_CONTROLS = 'Audio Controls'
    # AUDIO_ENABLED = 'Audio (Enabled)'
    # AUDIO_ON = 'Audio (On)'

    # AUDIO_INDEX = 'Audio INDEX'
    # AUDIO_NP = 'Audio NP'
  end
end
