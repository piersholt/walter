# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Off
        # Audio::Off::Actions
        module Actions
          include Logging

          # USER CONTROL

          def power(context)
            result = context.player.power
            logger.info(AUDIO_OFF) { "#power() => #{result}" }
            if result
              Wilhelm::API::Audio.instance.on
              context.on
            else
              Wilhelm::API::Audio.instance.off
              context.off
            end
            result
          end

          # UI

          def load_audio(context)
            logger.info(AUDIO_OFF) { '#load_audio()' }
            context.context.ui.launch(:audio, :index)
          end

          def load_now_playing(context)
            logger.info(AUDIO_OFF) { '#load_now_playing()' }
            context.context.ui.launch(:audio, :now_playing)
          end
        end
      end
    end
  end
end
