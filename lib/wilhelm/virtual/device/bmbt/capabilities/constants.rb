# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module Capabilities
          # BMBT::Capabilities::Constants
          module Constants
            POWER_PRESS   = 0x06
            POWER_HOLD    = 0x46
            POWER_RELEASE = 0x86

            MODE_NEXT_PRESS   = 0x33
            MODE_NEXT_HOLD    = 0x73
            MODE_NEXT_RELEASE = 0xB3

            NEXT_PRESS   = 0x00
            NEXT_HOLD    = 0x40
            NEXT_RELEASE = 0x80

            MENU_PRESS   = 0x34
            MENU_HOLD    = 0x74
            MENU_RELEASE = 0xB4

            CONFIRM_PRESS   = 0x05
            CONFIRM_HOLD    = 0x45
            CONFIRM_RELEASE = 0x85

            TONE_PRESS   = 0x04
            TONE_HOLD    = 0x44
            TONE_RELEASE = 0x84

            TP_PRESS = 0x32
            TP_HOLD = 0x72
            TP_RELEASE = 0xB2

            RDS_PRESS = 0x22
            RDS_HOLD = 0x62
            RDS_RELEASE = 0xA2

            OVERLAY_PRESS = 0x30
            OVERLAY_HOLD = 0x70
            OVERLAY_RELEASE = 0xB0
          end
        end
      end
    end
  end
end
