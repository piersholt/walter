# frozen_string_literal: true

class Walter
  class Audio
    # Comment
    module Actions
      include Constants

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
    end
  end
end
