# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module Capabilities
          # BMBT::Capabilities::Constants
          module Constants
            # Button State
            STATE_PRESS   = 0x00
            STATE_HOLD    = 0x40
            STATE_RELEASE = 0x80

            # Button ID
            POWER         = 0x06
            MODE_NEXT     = 0x33
            NEXT          = 0x00
            MENU          = 0x34
            CONFIRM       = 0x05
            TONE          = 0x04
            SELECT        = 0x20
            TP            = 0x32
            RDS           = 0x22
            OVERLAY       = 0x30
            EJECT         = 0x24

            EJECT_PRESS   = EJECT | STATE_PRESS
            EJECT_HOLD    = EJECT | STATE_HOLD
            EJECT_RELEASE = EJECT | STATE_RELEASE

            POWER_PRESS   = POWER | STATE_PRESS
            POWER_HOLD    = POWER | STATE_HOLD
            POWER_RELEASE = POWER | STATE_RELEASE

            MODE_NEXT_PRESS   = MODE_NEXT | STATE_PRESS
            MODE_NEXT_HOLD    = MODE_NEXT | STATE_HOLD
            MODE_NEXT_RELEASE = MODE_NEXT | STATE_RELEASE

            NEXT_PRESS   = NEXT | STATE_PRESS
            NEXT_HOLD    = NEXT | STATE_HOLD
            NEXT_RELEASE = NEXT | STATE_RELEASE

            MENU_PRESS   = MENU | STATE_PRESS
            MENU_HOLD    = MENU | STATE_HOLD
            MENU_RELEASE = MENU | STATE_RELEASE

            CONFIRM_PRESS   = CONFIRM | STATE_PRESS
            CONFIRM_HOLD    = CONFIRM | STATE_HOLD
            CONFIRM_RELEASE = CONFIRM | STATE_RELEASE

            TONE_PRESS   = TONE | STATE_PRESS
            TONE_HOLD    = TONE | STATE_HOLD
            TONE_RELEASE = TONE | STATE_RELEASE

            SELECT_PRESS   = SELECT | STATE_PRESS
            SELECT_HOLD    = SELECT | STATE_HOLD
            SELECT_RELEASE = SELECT | STATE_RELEASE

            TP_PRESS    = TP | STATE_PRESS
            TP_HOLD     = TP | STATE_HOLD
            TP_RELEASE  = TP | STATE_RELEASE

            RDS_PRESS   = RDS | STATE_PRESS
            RDS_HOLD    = RDS | STATE_HOLD
            RDS_RELEASE = RDS | STATE_RELEASE

            OVERLAY_PRESS   = OVERLAY | STATE_PRESS
            OVERLAY_HOLD    = OVERLAY | STATE_HOLD
            OVERLAY_RELEASE = OVERLAY | STATE_RELEASE
          end
        end
      end
    end
  end
end
