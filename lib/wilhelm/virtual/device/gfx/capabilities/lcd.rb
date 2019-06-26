# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # BMBT Interface Control
          module LCD
            include API
            include Constants
            include Helpers::Parse

            # Brightness: left to right, brightest to darkest
            # ["EC", "E0", "D4", "C8", "BC", "B0", "A4", "98", "8C", "80", "0C", "18", "24", "30", "3C", "48", "54", "60", "6C", "7F"]
            # Looks like signed magnitude?
            # No sign magnitude representation in Ruby
            # Array.new(10) { |i| (i * 12)+0b1000_0000 }.reverse +  Array.new(10) { |i| (i * 12) + 12 }

            # Request Brightness
            # gfx   bmbt	0x05  40 01
            # bmbt  gfx	  0x06  7F
            def brightness?
              lcd_brightness_set(arguments: bytes(0x40, 0x01))
            end

            # Set Brightness
            # gfx bmbt 05 41 01 60
            # gfx bmbt 05 42 01 60
            # Using 41 or 42 individually both seem to work.
            # Backwards compatability?
            def brightness(level)
              lcd_brightness_set(arguments: bytes(0x41, 0x01, level))
              lcd_brightness_set(arguments: bytes(0x42, 0x01, level))
            end
          end
        end
      end
    end
  end
end
