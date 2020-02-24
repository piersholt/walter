# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          module CheckControl
            # Device::IKE::Capabilities::CheckControl::Constants
            module Constants
              # Byte 1
              # 0b0000_0011
              CLEAR               = 0b000000_00
              SET                 = 0b000000_01
              OVERWRITE           = 0b000000_11

              # 0b0011_0000
              RANGE               = 0b00_01_0000
              PROG                = 0b00_10_0000
              CODE                = 0b00_11_0000

              # Byte 2
              # Gong  0b0000_0111
              GONG_OFF            = 0b00000_000
              GONG_HIGH_SINGLE    = 0b00000_001
              GONG_HIGH_TONE      = 0b00000_010
              GONG_HIGH_DOUBLE    = 0b00000_011
              GONG_LOW_SINGLE     = 0b00000_100

              # TBC   0b1111_0000
              CODE                = 0b0100_0000
              PROG                = 0b0100_0000
              RANGE_CLEAR         = 0b1000_0000
              RANGE_SET           = 0b1010_0000

              OPTS_RANGE_SET     = 0b1010 << 3 | GONG_LOW_SINGLE
              OPTS_RANGE_CLEAR   = 0b1000 << 3 | GONG_OFF
              OPTS_PROG_CLEAR    = 0b0100 << 3 | GONG_OFF
              OPTS_CODE_SET      = 0b0100 << 3 | GONG_LOW_SINGLE
              OPTS_CODE_CLEAR    = 0b0100 << 3 | GONG_OFF

              # Byte 3+
              CHARS_RANGE_DEFAULT = '   RANGE  34 KM     '
              CHARS_PROG_DEFAULT  = '        PROG        '
              CHARS_CODE_DEFAULT  = '      CODE ----     '
              CHARS_EMPTY_STRING  = ''
            end
          end
        end
      end
    end
  end
end
