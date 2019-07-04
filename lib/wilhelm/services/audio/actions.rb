# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Actions
      module Actions
        include Logging

        def volume_up
          logger.debug(AUDIO) { '#volume_up()' }
          @state.volume_up(self)
        end

        def volume_down
          logger.debug(AUDIO) { '#volume_down()' }
          @state.volume_down(self)
        end

        def overlay
          logger.debug(AUDIO) { '#overlay()' }
          @state.overlay(self)
        end

        def power
          logger.debug(AUDIO) { '#power()' }
          @state.power(self)
        end

        def pause
          logger.debug(AUDIO) { '#pause()' }
          @state.pause(self)
        end

        def seek_forward
          logger.debug(AUDIO) { '#seek_forward()' }
          @state.seek_forward(self)
        end

        def seek_backward
          logger.debug(AUDIO) { '#seek_backward()' }
          @state.seek_backward(self)
        end

        def scan_forward(toggle)
          logger.debug(AUDIO) { "#scan_forward(#{toggle})" }
          @state.scan_forward(self, toggle)
        end

        def scan_backward(toggle)
          logger.debug(AUDIO) { "#scan_backward(#{toggle})" }
          @state.scan_backward(self, toggle)
        end

        def load_audio
          logger.debug(AUDIO) { '#load_audio()' }
          @state.load_audio(self)
        end

        def load_now_playing
          logger.debug(AUDIO) { '#load_now_playing()' }
          @state.load_now_playing(self)
        end
      end
    end
  end
end
