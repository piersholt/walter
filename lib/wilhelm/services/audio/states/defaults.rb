# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      module Defaults
        # User Control

        def volume_up(context)
          false
        end

        def volume_down(context)
          false
        end

        def overlay(context)
          false
        end

        def power(context)
          false
        end

        def next_track(context)
          false
        end

        def prev(context)
          false
        end

        def scan_forward(toggle)
          false
        end

        def scan_backward(toggle)
          false
        end

        # API
        def everyone(context, properties)
          false
        end

        # PLAYER
        def track_change(context, properties)
          false
        end

        def track_start(context, properties)
          false
        end

        def track_end(context, properties)
          false
        end

        def position(context, properties)
          false
        end

        def status(context, properties)
          false
        end

        def repeat(context, properties)
          false
        end

        def shuffle(context, properties)
          false
        end

        # TARGET

        def addressed_player(context, properties)
          false
        end

        def player_added(context, properties)
          false
        end

        def player_changed(context, properties)
          false
        end

        def player_removed(context, properties)
          false
        end

      end
    end
  end
end
