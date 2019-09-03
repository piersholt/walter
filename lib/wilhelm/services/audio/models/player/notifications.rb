# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Notifications
        module Notifications
          include Logging

          def track_pending!
            logger.unknown(PROG) { '#track_pending!' }
            changed
            notify_observers(:track_pending, player: self)
          end

          def track_change!
            logger.unknown(PROG) { '#track_change!' }
            changed
            notify_observers(:track_change, player: self)
          end

          def track_start!
            logger.unknown(PROG) { '#track_start!' }
            timer.start!
            changed
            notify_observers(:track_start, player: self)
          end

          def track_end!
            logger.unknown(PROG) { '#track_end!' }
            timer.stop!
            timer.reset!
            changed
            notify_observers(:track_end, player: self)
          end

          def position!
            logger.unknown(PROG) { '#position!' }
            timer.elapsed_time = position
            changed
            notify_observers(:position, player: self)
          end

          def status!
            logger.unknown(PROG) { '#status!' }
            if playing?
              timer.start!
            elsif paused?
              timer.stop!
            else
              logger.warn(PROG) { "#status! Unknown status to update timer: #{status}" }
            end
            changed
            notify_observers(:status, player: self)
          end

          def repeat!
            logger.unknown(PROG) { '#repeat!' }
            changed
            notify_observers(:repeat, player: self)
          end

          def shuffle!
            logger.unknown(PROG) { '#shuffle!' }
            changed
            notify_observers(:shuffle, player: self)
          end

          def created!
            logger.unknown(PROG) { '#created!' }
            changed
            notify_observers(:created, player: self)
          end

          def updated!
            logger.unknown(PROG) { '#updated!' }
            timer.elapsed_time = position
            if playing?
              timer.start!
            elsif paused?
              timer.stop!
            else
              logger.warn(PROG) { "#status! Unknown status to update timer: #{status}" }
            end
            changed
            notify_observers(:updated, player: self)
          end
        end
      end
    end
  end
end
