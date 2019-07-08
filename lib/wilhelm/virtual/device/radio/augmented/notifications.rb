# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Augmented < Device::Augmented
          # Device::Radio::Augmented
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
              LOGGER.debug(self.class.name) { "#track_change(#{new_track})" }
              self.track = new_track
              render_track(self.track)
            rescue StandardError => e
              LOGGER.error(self.class) { e }
              e.backtrace.each { |line| LOGGER.warn(line) }
            end
          end
        end
      end
    end
  end
end
