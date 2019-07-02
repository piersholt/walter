# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class On
        # Audio::On::Actions
        module Actions
          include Logging

          # USER CONTROL

          def volume_up(context)
            context.target.volume_up
          end

          def volume_down(context)
            context.target.volume_down
          end

          def power(context)
            result = context.player.power
            logger.info(AUDIO_ON) { "#power() => #{result}" }
            if result
              Wilhelm::API::Audio.instance.on
            else
              Wilhelm::API::Audio.instance.off
            end
            result
          end

          def pause(context)
            result = context.player.pause
            logger.info(AUDIO_ON) { "#pause() => #{result}" }
            result
          end

          def seek_forward(context)
            logger.info(AUDIO_ON) { "#seek_forward()" }
            context.player.seek_forward
          end

          def seek_backward(context)
            logger.info(AUDIO_ON) { "#seek_backward()" }
            context.player.seek_backward
          end

          def scan_forward(context, toggle)
            logger.debug(AUDIO) { "#scan_forward(#{toggle})" }
            case toggle
            when :on
              context.player.scan_forward_start
            when :off
              context.player.scan_forward_stop
            end
          end

          def scan_backward(context, toggle)
            logger.debug(AUDIO) { "#scan_back(#{toggle})" }
            case toggle
            when :on
              context.player.scan_backward_start
            when :off
              context.player.scan_backward_stop
            end
          end
        end
      end
    end
  end
end
