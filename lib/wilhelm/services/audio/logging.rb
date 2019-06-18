# frozen_string_literal: true

module Wilhelm
  class Audio
    # Comment
    module Logging
      include Constants

      def to_s
        "Audio (#{state_string})"
      end

      def nickname
        :audio
      end

      def state_string
        case state
        when On
          'Available'
        when Enabled
          'Pending'
        when Disabled
          'Disabled'
        else
          state.class
        end
      end

      def logger
        LogActually.audio_service
      end
    end
  end
end
