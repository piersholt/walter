# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Comment
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
          LOGGER
        end
      end
    end
  end
end
