# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          # LCM::Capabilities::Constants
          module Constants
            # Byte 1
            # loops every 0b111 bits
            DISPLAY_OFF     = 0b000
            DISPLAY_UPDATE  = 0b001 # very faint if preceeded by 0
            DISPLAY_SET     = 0b010
            DISPLAY_Y       = 0b100

            UNKNOWN         = 0b0000_1000 # this will clear on own... 0x08

            GONG            = 0b0001_0000   # enabled "gong" flags
            CHEVRON         = 0b0010_0000   # enabled "chevron" flags


            RECALL  = GONG | CHEVRON | 0b101       # 0x35
            PERSIST = GONG | CHEVRON | 0b110       # 0x36 won't set chevrons on own
            ALERT   = GONG | CHEVRON | 0b111       # 0x37

            # Byte 2
            # CHEVRON 0b0000_0011
            # GONG    0b0001_1100

            CHEV_OFF    = 0b00
            CHEV_ON     = 0b01
            CHEV_BLINK  = 0b11

            GONG_NONE   = 0b000 << 2
            GONG_1      = 0b000 << 2
            GONG_2      = 0b001 << 2
            GONG_3      = 0b010 << 2
            GONG_4      = 0b011 << 2
            GONG_5      = 0b100 << 2

            # Byte 3

            MSG_NIL           = ""
            MSG_BLANK         = "                    "
            MSG_OK            = "  CHECK CONTROL OK  "
            MSG_RELEASE       = "RELEASE PARKINGBRAKE"
            MSG_OIL_PRES      = "STOP!ENGINE OILPRESS"
            MSG_OIL_LEVEL     = "CHECK ENGINE OIL LEV"
            MSG_COOLANT_TEMP  = "COOLANT TEMPERATURE"
            MSG_TRANS         = "TRANS. FAILSAFE PROG"
            MSG_BRAKE_FLUID   = "CHECK BRAKE FLUID"
            MSG_BRAKE_LINING  = "CHECK BRAKE LININGS "
            MSG_FLAT_TIRE     = "FLAT TIRE"
            MSG_LOAD_INACT    = "LOAD LEVEL INACTIVE"
            MSG_SPEED         = "SPEED LIMIT"
            MSG_SLS_INACT     = "SELFLEVEL SUSP.INACT"

            MSG_ALL = [
              MSG_RELEASE,
              MSG_OIL_PRES,
              MSG_COOLANT_TEMP,
              MSG_SPEED,
              MSG_BRAKE_FLUID,
              MSG_FLAT_TIRE,
              MSG_LOAD_INACT
            ].freeze
          end
        end
      end
    end
  end
end
