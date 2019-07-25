# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Notifications
        module Notifications
          include Logging

          def track_pending
            changed
            notify_observers(:track_pending, player: self)
          end

          def track_change
            changed
            notify_observers(:track_change, player: self)
          end

          def track_start
            changed
            notify_observers(:track_start, player: self)
          end

          def track_end
            changed
            notify_observers(:track_end, player: self)
          end

          def position
            changed
            notify_observers(:position, player: self)
          end

          # @note conflict with attribute of same name
          # def status
          #   changed
          #   notify_observers(:status, player: self)
          # end

          def repeat
            changed
            notify_observers(:repeat, player: self)
          end

          def shuffle
            changed
            notify_observers(:shuffle, player: self)
          end

          def created
            changed
            notify_observers(:created, player: self)
          end

          def updated
            changed
            notify_observers(:updated, player: self)
          end
        end
      end
    end
  end
end
