# frozen_string_literal: true

module Capabilities
  module MultiFunctionWheel
    # Comment
    module Constants
      MAGNITUDE_DEFAULT = 1
      MAGNITUDE_OFFSET = 0b0000_1111
      MAGNITUDE_MAX = 15

      VOLUME_UP   = 0b0000_0001
      VOLUME_DOWN = 0b0000_0000

      STATE_PRESS   = 0b0000_0000
      STATE_HOLD    = 0b0001_0000
      STATE_RELEASE = 0b0010_0000

      # 0x80, 0x90, 0xA0
      TEL_PRESS   = 0b1000_0000 + STATE_PRESS
      TEL_HOLD    = 0b1000_0000 + STATE_HOLD
      TEL_RELEASE = 0b1000_0000 + STATE_RELEASE

      # 0x80, 0x90, 0xA0
      NEXT_PRESS   = 0b0000_0001 + STATE_PRESS
      NEXT_HOLD    = 0b0000_0001 + STATE_HOLD
      NEXT_RELEASE = 0b0000_0001 + STATE_RELEASE

      # 0x80, 0x90, 0xA0
      PREV_PRESS   = 0b0000_1000 + STATE_PRESS
      PREV_HOLD    = 0b0000_1000 + STATE_HOLD
      PREV_RELEASE = 0b0000_1000 + STATE_RELEASE

      RT_RAD_PRESS   = 0b0000_0000
      RT_TEL_PRESS   = 0b0100_0000
    end
  end
end
