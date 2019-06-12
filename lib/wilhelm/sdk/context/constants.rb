# frozen_string_literal: true

# Top level namespace
module Wilhelm::SDK
  # Comment
  module Constants
    include LogActually::ErrorOutput

    WILHELM = 'Wilhelm'
    WILHELM_OFFLINE = 'Wilhelm (Offline)'
    WILHELM_EST = 'Wilhelm (Est.)'
    WILHELM_ONLINE = 'Wilhelm (Online)'

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
