# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module CDChanger
            # Radio::Capabilities::CDChanger::Constants
            module Constants
              include Capabilities::Constants

              # 0x21
              CDC_DISCS_SOURCE = 0b0_0000 << 0 # 0xc0

              CDC_DISCS =
                " 1\x052 \x05" \
                " 3\x054 \x05" \
                " 5\x056 "

              CDC_SOURCES =
                "FM\x05AM\x05" \
                "SC\x05RND\x05" \
                "TAPE\x05    "

              # 0x23
              CDC_FAST_FORWARD    = 0x05  # 'CD 1-01  >>' [>>]
              CDC_REWIND          = 0x06  # 'CD 1-01 <<R' [<R]

              CDC_SEEK            = 0x04  # 'CD 1-01'     [< >]
              CDC_SCAN            = 0x0a  # 'CD 1-01'     [<< >>]
              CDC_SAMPLE          = 0x07  # 'CD 1-02  SC' [SCAN]
              CDC_SHUFFLE         = 0x08  # 'CD 1-01 RND' [RND]

              CDC_NO_MAGAZINE     = 0x01  # 'NO MAGAZINE'
              CDC_NO_DISC         = 0x02  # 'NO DISC'

              CDC_DISC_LOAD       = 0x0b  # 'CD 0-00'

              DEFAULT_FF          = 'CD 1-01  >>'
              DEFAULT_RW          = 'CD 1-01 <<R'
              DEFAULT_SEEK        = 'CD 1-01'
              DEFAULT_SCAN        = 'CD 1-01'
              DEFAULT_SAMPLE      = 'CD 1-01  SC'
              DEFAULT_SHUFFLE     = 'CD 1-01 RND'
              DEFAULT_NO_MAGAZINE = 'NO MAGAZINE'
              DEFAULT_NO_DISC     = 'NO DISC'
              DEFAULT_DISC_LOAD   = 'CD 0-00'

              # 0x38
              CONTROL_STATUS        = 0x00
              CONTROL_STOP          = 0x01
              CONTROL_PLAY          = 0x03
              CONTROL_SCAN          = 0x04  # RWD/FFD
              CONTROL_SEEK          = 0x05  # Previous/Next
              CONTROL_CHANGE_DISC   = 0x06
              CONTROL_SCAN_MODE     = 0x07
              CONTROL_RANDOM_MODE   = 0x08
              CONTROL_CHANGE_TRACK  = 0x0A
            end
          end
        end
      end
    end
  end
end
