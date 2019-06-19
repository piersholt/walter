# frozen_string_literal: false

module Wilhelm
  module API
    class Audio
      # Audio API LED methods
      module LED
        def on
          bus.rad.led_on
        end

        def off
          bus.rad.led_off
        end

        def power
          case bus.bmbt.power?
          when false
            on
          when true
            off
          end
        end
      end
    end
  end
end
