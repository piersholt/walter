# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          # Device::IKE::Capabilities::CheckControl
          module CheckControl
            include API

            # 80 19 30 52
            # 0b0001_0001 RANGE | SET
            # 0b1001_0100 RANGE_540 | GONG_LOW_SINGLE
            # "   RANGE  50 KM     "
            # 02

            # Byte 1
            # 0b0011_0000
            CODE                = 0b0011_0000
            PROG                = 0b0010_0000
            RANGE               = 0b0001_0000

            # 0b0000_0011
            OVERWRITE           = 0b0000_0011
            SET                 = 0b0000_0001
            CLEAR               = 0b0000_0000

            # Byte 2
            # TBC   0b1111_0000
            RANGE_SET           = 0b1010_0000 # 0xa0
            RANGE_540           = 0b1001_0000 # 0x9
            RANGE_CLEAR         = 0b1000_0000
            CODE                = 0b0100_0000
            PROG                = 0b0100_0000

            # Gong  0b0000_0111
            GONG_LOW_SINGLE     = 0b0000_0100 # 0x04
            GONG_HIGH_DOUBLE    = 0b0000_0011
            GONG_HIGH_TONE      = 0b0000_0010
            GONG_HIGH_SINGLE    = 0b0000_0001
            GONG_OFF            = 0b0000_0000

            # Byte 3+
            CHARS_RANGE_DEFAULT = '   RANGE  99 KM     '
            CHARS_PROG_DEFAULT  = '        PROG        '
            CHARS_CODE_DEFAULT  = '      CODE ----     '
            CHARS_EMPTY_STRING  = ''

            # CODE -------------------------------------------------

            def warn_code
              ccm_relay(
                b1:     CODE | SET,
                b2:     GONG_LOW_SINGLE,
                chars:  CHARS_CODE_DEFAULT
              )
            end

            def warn_code_clear
              ccm_relay(
                b1:     CODE | CLEAR,
                b2:     GONG_OFF,
                chars:  CHARS_EMPTY_STRING
              )
            end

            # PROG -------------------------------------------------

            def warn_prog
              ccm_relay(
                b1:     PROG | SET,
                b2:     GONG_LOW_SINGLE,
                chars:  CHARS_PROG_DEFAULT
              )
            end

            def warn_prog_clear
              ccm_relay(
                b1:     PROG | CLEAR,
                b2:     GONG_OFF,
                chars:  CHARS_EMPTY_STRING
              )
            end

            # RANGE -------------------------------------------------

            def warn_range
              ccm_relay(
                b1:     RANGE | SET,
                b2:     GONG_LOW_SINGLE,
                chars:  CHARS_RANGE_DEFAULT
              )
            end

            def warn_range_clear
              ccm_relay(
                b1:     RANGE | CLEAR,
                b2:     GONG_OFF,
                chars:  CHARS_EMPTY_STRING
              )
            end
          end
        end
      end
    end
  end
end
