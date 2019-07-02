# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      module Defaults
        # Audio::Defaults::Notifications
        module Notifications
          # PLAYER
          def track_change(*)
            false
          end

          def track_start(*)
            false
          end

          def track_end(*)
            false
          end

          def position(*)
            false
          end

          def status(*)
            false
          end

          def repeat(*)
            false
          end

          def shuffle(*)
            false
          end

          # TARGET

          def addressed_player(*)
            false
          end

          def player_added(*)
            false
          end

          def player_changed(*)
            false
          end

          def player_removed(*)
            false
          end
        end
      end
    end
  end
end
