# frozen_string_literal: true

module Capabilities
  module OnBoardMonitor
    # Comment
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
    end
  end
end
