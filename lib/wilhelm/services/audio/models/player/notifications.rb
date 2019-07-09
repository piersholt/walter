# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Notifications
        module Notifications
          include Logging

          # Target (Addressed Player)

          def player_added!(*)
            # attributes!(player_object)
            changed
            notify_observers(:player_added, player: self)
          end

          def player_changed!(*)
            # attributes!(player_object)
            changed
            notify_observers(:player_changed, player: self)
          end

          def player_removed!
            # destroy!
            changed
            notify_observers(:player_removed, player: self)
          end

          # Player

          def track_change!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:track_change, player: self)
          end

          def track_start!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:track_start, player: self)
          end

          def track_end!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:track_end, player: self)
          end

          def position!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:position, player: self)
          end

          def status!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:status, player: self)
          end

          def repeat!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:repeat, player: self)
          end

          def shuffle!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:shuffle, player: self)
          end

          def changed!(player_object)
            attributes!(player_object)
            changed
            notify_observers(:changed, player: self)
          end
        end
      end
    end
  end
end
