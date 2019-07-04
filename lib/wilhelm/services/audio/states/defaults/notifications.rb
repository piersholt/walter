# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      module Defaults
        # Audio::Defaults::Notifications
        module Notifications
          # PLAYER
          def track_change(*); end

          def track_start(*); end

          def track_end(*); end

          def position(*); end

          def status(*); end

          def repeat(*); end

          def shuffle(*); end

          # TARGET

          def addressed_player(*); end

          def player_added(*); end

          def player_changed(*); end

          def player_removed(*); end
        end
      end
    end
  end
end
