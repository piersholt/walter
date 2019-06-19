# frozen_string_literal: true

# Comment
module Wilhelm
  class Virtual
    # Comment
    class AugmentedRadio < AugmentedDevice
      module Notifications
        attr_accessor :track

        def render_track(track)
          title = self.track['Title']
          artist = self.track['Artist']
          album = self.track['Album']
          title(chars: title)
          subheading_a(chars: artist)
          subheading_b(chars: album)
        end

        def track_change(new_track)
          LogActually.messaging.debug(self.class.name) { "#track_change(#{new_track})" }
          self.track = new_track
          render_track(self.track)
        rescue StandardError => e
          LogActually.messaging.error(self.class) { e }
          e.backtrace.each { |line| LogActually.messaging.warn(line) }
        end
      end
    end
  end
end
