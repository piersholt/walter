# frozen_string_literal: true

# Top level namespace
module Wilhelm::SDK
  # Default Wilhelm logger
  class UserInterface
    module Constants
      include LogActually::ErrorOutput

      # AUDIO_INDEX = 'Audio INDEX'
      # AUDIO_NP = 'Audio NP'

      def logger
        LogActually.ui
      end
    end
  end
end
