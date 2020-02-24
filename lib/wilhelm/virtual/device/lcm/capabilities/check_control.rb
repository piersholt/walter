# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          # LCM::Capabilities::CheckControl
          module CheckControl
            include Helpers::Data

            # Byte 1
            # 0b0011_0000
            CHEVRON     = 0b0010_0000 # enabled "chevron" flags
            GONG        = 0b0001_0000 # enabled "gong" flags

            # 0b0000_1111
            UPDATE      = 0b0000_1000
            Y           = 0b0000_0100
            X           = 0b0000_0010
            FAINT       = 0b0000_0001 # very faint if preceeded by 0
            FLUSH       = 0b0000_0000

            # Byte 2
            # Gong  0b0001_1100
            GONG_5      = 0b0001_0000
            GONG_4      = 0b0000_1100
            GONG_3      = 0b0000_1000
            GONG_2      = 0b0000_0100
            GONG_1      = 0b0000_0000

            # Chevron 0b0000_0011
            CHEV_BLINK  = 0b0000_0011
            CHEV_ON     = 0b0000_0001
            CHEV_OFF    = 0b0000_0000

            def check(
              byte1,
              byte2,
              chars = generate_chars(5..20)
            )
              ccm(b1: byte1, b2: byte2, chars: chars)
            end
          end
        end
      end
    end
  end
end
