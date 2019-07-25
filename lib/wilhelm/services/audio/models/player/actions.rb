# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Actions
        module Actions
          include Yabber::API
          include Logging

          def power
            logger.debug(PROG) { '#power' }
            if on?
              stop
              false
            else
              play
              true
            end
          end

          def play
            logger.debug(PROG) { '#play' }
            play!(id)
          end

          def pause
            logger.debug(PROG) { '#pause' }
            if play?
              pause!(id)
              true
            elsif paused?
              play
              false
            end
          end

          def stop
            logger.debug(PROG) { '#stop' }
            stop!(id)
          end

          def seek_forward
            logger.debug(PROG) { '#seek_forward' }
            return false unless on?
            next!(id)
          end

          def seek_backward
            logger.debug(PROG) { '#seek_backward' }
            return false unless on?
            previous!(id)
          end

          def scan_forward_start
            logger.debug(PROG) { '#scan_forward_start' }
            scan_forward_start!(id)
          end

          def scan_forward_stop
            logger.debug(PROG) { '#scan_forward_stop' }
            scan_forward_stop!(id)
          end

          def scan_backward_start
            logger.debug(PROG) { '#scan_backward_start' }
            scan_backward_start!(id)
          end

          def scan_backward_stop
            logger.debug(PROG) { '#scan_backward_stop' }
            scan_backward_stop!(id)
          end
        end
      end
    end
  end
end
