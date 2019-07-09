# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Actions
        module Actions
          include Yabber::API
          def power
            if on?
              stop!
              false
            else
              play!
              true
            end
          end

          def pause
            if play?
              pause!
              true
            elsif paused?
              play!
              false
            end
          end

          def seek_forward
            return false unless on?
            next!
          end

          def seek_backward
            return false unless on?
            previous!
          end

          def scan_forward_start
            scan_forward_start!
          end

          def scan_forward_stop
            scan_forward_stop!
          end

          def scan_backward_start
            scan_backward_start!
          end

          def scan_backward_stop
            scan_backward_stop!
          end
        end
      end
    end
  end
end
