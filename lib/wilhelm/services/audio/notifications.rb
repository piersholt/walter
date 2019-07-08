# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Notifications
      module Notifications
        # NOTIFICATIONS (TARGET) ----------------------------------------------

        def addressed_player(properties)
          @state.addressed_player(self, properties)
        end

        def player_added(properties)
          @state.player_added(self, properties)
        end

        def player_changed(properties)
          @state.player_changed(self, properties)
        end

        def player_removed(properties)
          @state.player_removed(self, properties)
        end

        # NOTIFICATIONS (PLAYER) ----------------------------------------------

        def track_change(properties)
          @state.track_change(self, properties)
        end

        def track_start(properties)
          @state.track_start(self, properties)
        end

        def track_end(properties)
          @state.track_end(self, properties)
        end

        def position(properties)
          @state.position(self, properties)
        end

        def status(properties)
          @state.status(self, properties)
        end

        def repeat(properties)
          @state.repeat(self, properties)
        end

        def shuffle(properties)
          @state.shuffle(self, properties)
        end
      end
    end
  end
end
