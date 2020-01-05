# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module Settings
            # Settings: LCD Brightness
            module Brightness
              include API
              include Constants
              include Helpers::Parse

              # Request BMBT LCD Brightness
              def brightness?
                lcd_brightness_set(arguments: bytes(BMBT_BRIGHTNESS, 0x01))
              end

              # Set BMBT/RCM LCD Brightness
              # @param SignedMagnitude level -10 to 10
              def brightness!(level)
                validate_brightness(level)
                lcd_brightness_set(
                  arguments: bytes(BMBT_BRIGHTNESS_FRONT, 0x01, level)
                )
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
                return false unless brightness_range?(*values)
                true
              end

              def brightness_range?(*values)
                valid_range?(BRIGHTNESS_RANGE, *values)
              end
            end
          end
        end
      end
    end
  end
end
