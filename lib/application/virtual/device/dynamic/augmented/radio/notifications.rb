# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    module Notifications
      def track_change(track)
        title = track['Title']
        artist = track['Artist']
        output = "#{title} / #{artist}"
        displays( { chars: output, gfx: 0xC4, ike: 0x30,}, my_address, address(:glo_h) )
      rescue StandardError => e
        LOGGER.error(self.class) { e }
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
