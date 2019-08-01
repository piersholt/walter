# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Actions
      module Actions
        include Logging
        include Yabber::API

        def volume_up
          logger.debug(stateful) { '#volume_up()' }
          @state.volume_up(self)
        end

        def volume_down
          logger.debug(stateful) { '#volume_down()' }
          @state.volume_down(self)
        end

        def volume_set(level)
          logger.debug(stateful) { "#volume_set(#{level})" }
          @state.volume_set(self, level)
        end

        def overlay
          logger.debug(stateful) { '#overlay()' }
          @state.overlay(self)
        end

        def power
          logger.debug(stateful) { '#power()' }
          @state.power(self)
        end

        def pause
          logger.debug(stateful) { '#pause()' }
          @state.pause(self)
        end

        def seek_forward
          logger.debug(stateful) { '#seek_forward()' }
          @state.seek_forward(self)
        end

        def seek_backward
          logger.debug(stateful) { '#seek_backward()' }
          @state.seek_backward(self)
        end

        def scan_forward(toggle)
          logger.debug(stateful) { "#scan_forward(#{toggle})" }
          @state.scan_forward(self, toggle)
        end

        def scan_backward(toggle)
          logger.debug(stateful) { "#scan_backward(#{toggle})" }
          @state.scan_backward(self, toggle)
        end

        def load_audio
          logger.debug(stateful) { '#load_audio()' }
          @state.load_audio(self)
        end

        def load_now_playing
          logger.debug(stateful) { '#load_now_playing()' }
          @state.load_now_playing(self)
        end
      end
    end
  end
end
