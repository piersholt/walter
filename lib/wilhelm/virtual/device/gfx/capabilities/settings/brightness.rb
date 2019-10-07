# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module Settings
            # Settings: LCD Brightness
            module Brightness
              include API
              include Constants
              include Helpers::Parse

              # Brightness: left to right, brightest to darkest
              # ["EC", "E0", "D4", "C8", "BC", "B0", "A4", "98", "8C", "80", "0C", "18", "24", "30", "3C", "48", "54", "60", "6C", "7F"]
              # Looks like signed magnitude?
              # No signed magnitude representation in Ruby
              # Array.new(10) { |i| (i * 12)+0b1000_0000 }.reverse +  Array.new(10) { |i| (i * 12) + 12 }
              BRIGHTNESS_INTERVALS = [
                0xFF, 0xEC, 0xE0, 0xD4, 0xC8, 0xBC, 0xB0,
                0xA4, 0x98, 0x8C, 0x80, 0x0C, 0x18, 0x24,
                0x30, 0x3C, 0x48, 0x54, 0x60, 0x6C, 0x7F
              ].freeze

              BRIGHTNESS_RANGE = (0..(BRIGHTNESS_INTERVALS.size - 1))

              # Request BMBT LCD Brightness
              # gfx   bmbt	0x05  40 01
              # bmbt  gfx	  0x06  7F
              def brightness?
                lcd_brightness_set(arguments: bytes(0x40, 0x01))
              end

              # Set BMBT LCD Brightness
              # gfx bmbt 05 41 01 60
              # gfx bmbt 05 42 01 60
              # 0x41 and 0x42 may represent BMBT and RCM?
              # @param Integer level 0 to 20
              def brightness!(level)
                validate_brightness(level)
                smr = BRIGHTNESS_INTERVALS[level]
                lcd_brightness_set(arguments: bytes(0x41, 0x01, smr))
                # lcd_brightness_set(arguments: bytes(0x42, 0x01, smr))
              end

              private

              def validate_brightness(*values)
                return true if valid_brightness?(*values)
                raise(
                  ArgumentError,
                  "Invalid brightness! #{values}"
                )
              end

              def valid_brightness?(*values)
                return false unless integers?(*values)
                return false if negative?(*values)
                return false unless brightness_range?(*values)
                true
              end

              def brightness_range?(*values)
                range?(BRIGHTNESS_RANGE, *values)
              end
            end
          end
        end
      end
    end
  end
end
