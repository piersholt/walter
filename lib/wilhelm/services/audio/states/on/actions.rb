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
            context.level += 1
            context.volume_up!
            # context.volume_set(context.level)
          end

          def volume_down(context)
            context.level -= 1
            context.volume_down!
            # context.volume_set(context.level)
          end

          def volume_set(context, level)
            context.volume_set!(level)
            context.changed
            context.notify_observers(:volume, audio: context)
          end

          def power(context)
            result = context.target.addressed_player.power
            logger.info(AUDIO_ON) { "#power() => #{result ? 'On' : 'Off'}" }
            case result
            when true
              Wilhelm::API::Audio.instance.on
              context.on
            when false
              Wilhelm::API::Audio.instance.off
              context.off
            end
            result
          end

          def pause(context)
            result = context.target.addressed_player.pause
            logger.info(AUDIO_ON) { "#pause() => #{result}" }
            result
          end

          def seek_forward(context)
            logger.debug(AUDIO_ON) { "#seek_forward()" }
            context.target.addressed_player.seek_forward
          end

          def seek_backward(context)
            logger.debug(AUDIO_ON) { "#seek_backward()" }
            context.target.addressed_player.seek_backward
          end

          def scan_forward(context, toggle)
            logger.debug(AUDIO_ON) { "#scan_forward(#{toggle})" }
            case toggle
            when :on
              context.target.addressed_player.scan_forward_start
            when :off
              context.target.addressed_player.scan_forward_stop
            end
          end

          def scan_backward(context, toggle)
            logger.debug(AUDIO_ON) { "#scan_back(#{toggle})" }
            case toggle
            when :on
              context.target.addressed_player.scan_backward_start
            when :off
              context.target.addressed_player.scan_backward_stop
            end
          end

          def load_audio(context)
            logger.debug(AUDIO_ON) { '#load_audio()' }
            context.context.ui.launch(:audio, :index)
          end

          def load_now_playing(context)
            logger.debug(AUDIO_ON) { '#load_now_playing()' }
            context.context.ui.launch(:audio, :now_playing)
          end
        end
      end
    end
  end
end
