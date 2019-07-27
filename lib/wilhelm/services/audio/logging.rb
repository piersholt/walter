# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Logging
      module Logging
        include Constants
        include LogActually::ErrorOutput

        def to_s
          # Issue with change_state notification
          # State classes use Logging from service,
          # but have no state variable.. causing #stateful to error
          return stateful if self.respond_to?(:state)
          super()
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
          when Pending
            AUDIO_STATE_PENDING
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
          LogActually.audio
        end
      end
    end
  end
end
