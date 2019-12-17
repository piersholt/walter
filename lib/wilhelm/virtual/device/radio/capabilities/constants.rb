# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Radio::Capabilities::Constants
          module Constants
            # LAYOUT ----------------------------------------------------------
            SOURCE_SERVICE  = 0b000 << 5 # 0x00
            SOURCE_WEATHER  = 0b001 << 5 # 0x20
            SOURCE_ANALOGUE = 0b010 << 5 # 0x40
            SOURCE_DIGITAL  = 0b011 << 5 # 0x60
            SOURCE_TAPE     = 0b100 << 5 # 0x80
            SOURCE_TMC      = 0b101 << 5 # 0xa0
            SOURCE_CDC      = 0b110 << 5 # 0xc0
            SOURCE_NA       = 0b111 << 5 # 0xe0

            # M2 / PADDING ----------------------------------------------------
            # 0x21
            RDS                 = 0b0_0010
            TP                  = 0b0_0100
            TP_ACTIVE           = 0b0_1000

            # 0xA5
            PADDING_NONE        = 0b0000_0001

            # M3 / ZONE -------------------------------------------------------

            # CHARS -----------------------------------------------------------
            P_BREAK     = 0x05
            P_CR        = 0x06
            P_PAD       = 0x20
            P_STAR      = 0x2a
          end
        end
      end
    end
  end
end
