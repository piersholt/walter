# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::State
        module State
          include Constants

          def power?
            if on?
              true
            elsif off?
              false
            else
              false
            end
          end

          def on?
            STATUS_ON.one? { |s| s == status }
          end

          alias play? on?

          def off?
            STATUS_OFF.one? { |s| s == status }
          end

          def paused?
            STATUS_PAUSE.one? { |s| s == status }
          end
        end
      end
    end
  end
end
