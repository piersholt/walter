# frozen_string_literal: true

# Top level namespace
class Walter
  # Default Wilhelm logger
  module Constants
    include LogActually::ErrorOutput

    MANAGER = 'Mananger'
    MANAGER_CONTROLS = 'Mananger Controls'
    MANAGER_DISABLED = 'Mananger (Disabled)'
    MANAGER_ENABLED = 'Mananger (Enabled)'
    MANAGER_ON = 'Mananger (On)'

    # AUDIO_INDEX = 'Audio INDEX'
    # AUDIO_NP = 'Audio NP'

    def logger
      LogActually.wolfgang
    end
  end
end
