# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Logging
      module Logging
        include Constants
        include LogActually::ErrorOutput

        def to_s
          stateful
        end

        def nickname
          :audio
        end

        def stateful
          "Audio (#{state_string})"
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

        def debug(message, prog = PROG)
          logger.debug(prog) { message }
        end

        def info(message, prog = PROG)
          logger.info(prog) { message }
        end

        def warn(message, prog = PROG)
          logger.warn(prog) { message }
        end

        def logger
          LOGGER
        end
      end
    end
  end
end
