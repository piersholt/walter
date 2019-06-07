# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    module Notifications
      attr_accessor :track

      def render_track(track)
        title = self.track['Title']
        artist = self.track['Artist']
        album = self.track['Album']
        # output = "#{title} / #{artist}"
        # displays( { chars: output, gfx: 0xC4, ike: 0x30,}, my_address, address(:glo_h) )
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

# ----------------------- AUGMENTED HANDLING --------------------- #


# def track_change(track)
#   return false if @thread
#   @thread = Thread.new(track) do |t|
#     begin
#       LOGGER.fatal(self.class) { t }
#       title = t['Title']
#       artist = t['Artist']
#       scroll = "#{title} / #{artist}"
#
#       displays( { chars: '', gfx: 0xC4, ike: 0x20,}, my_address, address(:ike) )
#
#       i = 0
#       last = scroll.length
#
#       while i <= last do
#         scroll = scroll.bytes.rotate(i).map { |i| i.chr }.join
#         displays( { chars: scroll, gfx: 0xC4, ike: 0x30,}, my_address, address(:ike) )
#         sleep(2)
#         i += 1
#       end
#     rescue StandardError => e
#       LOGGER.error(self.class) { e }
#     end
#   end
#   @thread = nil
#   true
# end
