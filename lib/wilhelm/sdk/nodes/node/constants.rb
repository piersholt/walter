# frozen_string_literal: true

# Top level namespace
module Wilhelm
  class Node
    # Comment
    module Constants
      include LogActually::ErrorOutput

      NODE = 'Node'
      NODE_OFFLINE = 'Node (Offline)'
      NODE_EST = 'Node (Est.)'
      NODE_ONLINE = 'Node (Online)'

      PING_INTERVAL = 30

      DEFAULT_NICKNAME = :node

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
end
