# frozen_string_literal: true

# BYTE 1

# Source: Bits
SOURCE_NAV_GT = 0b0000_0000
SOURCE_TV     = 0b0000_0001
SOURCE_VM_GT  = 0b0000_0010

MONITOR_OFF   = 0b0000_0000
MONITOR_ON    = 0b0001_0000

# BYTE 2
ENCODING_NTSC = 0b0000_0001
ENCODING_PAL  = 0b0000_0010

ASPECT_4_3    = 0b0000_0000
ASPECT_16_9   = 0b0001_0000
ASPECT_ZOOM   = 0b0011_0000

module Wilhelm
  module Virtual
    class Device
      module BMBT
        class Augmented < Device::Augmented
          # BMBT::Augmented::Received
          module Received
            def handle_rad_led(command)
              case command.led?
              when :on
                on!
              when :radio
                on!
              when :tape
                on!
              when :reset
                off!
              when :off
                off!
              end
            end

            private

            # TODO should be state...
            def on!
              @power = true
            end

            def off!
              @power = false
            end

            def power?
              @power ||= false
            end
          end
        end
      end
    end
  end
end
