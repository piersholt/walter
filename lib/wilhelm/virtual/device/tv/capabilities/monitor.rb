# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module TV
        module Capabilities
          # TV::Capabilities::Monitor
          module Monitor
            include API
            include Constants
            include Wilhelm::Helpers::Parse

            # BYTE 1
            # Source:       0b0000_0011
            SOURCE_NAV_GT = 0b0000_0000
            SOURCE_TV     = 0b0000_0001
            SOURCE_VID_GT = 0b0000_0010

            # Power:        0b0001_0000
            MONITOR_OFF   = 0b0000_0000
            MONITOR_ON    = 0b0001_0000

            # BYTE 2
            # Aspect:       0b0011_0000
            ASPECT_4_3    = 0b0000_0000
            ASPECT_16_9   = 0b0001_0000
            ASPECT_ZOOM   = 0b0011_0000

            # Encoding:     0b0000_0011
            ENCODING_NTSC = 0b0000_0001
            ENCODING_PAL  = 0b0000_0010

            def monitor(*args)
              src_gt(arguments: bytes(*args))
            end

            def mk1
              src_gt(
                a: SOURCE_NAV_GT | MONITOR_ON,
                b: ASPECT_4_3 | ENCODING_PAL
              )
            end
          end
        end
      end
    end
  end
end
