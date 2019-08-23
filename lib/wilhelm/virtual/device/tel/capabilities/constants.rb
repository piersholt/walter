# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Radio::Capabilities::Constants
          module Constants
            include Telephone::Constants
            ZERO = 0x00

            # -----------------------------------------------------------------
            # PARAMETER 1: LAYOUT
            # -----------------------------------------------------------------
            LAYOUT_DIRECTORY = 0x4_3
            LAYOUT_TOP_8     = 0x8_0
            LAYOUT_SMS_INDEX = 0xf_0
            LAYOUT_SMS_SHOW  = 0xf_1
            LAYOUT_SOS       = 0xf_1

            # -----------------------------------------------------------------
            # PARAMETER 2: PADDING
            # -----------------------------------------------------------------
            PADDING_ZERO = 0x00

            PADDING_NONE = 0x01

            # -----------------------------------------------------------------
            # PARAMETER 3: ZONE
            # -----------------------------------------------------------------
            INDEX_ZERO = 0x00

            # Selected works on both 0xf0 and 0xf1
            SELECTED   = 0b1000_0000
            BLOCK      = 0b0100_0000
            FLUSH      = 0b0010_0000

            INDEX_0    = 0b0000_0000
            INDEX_1    = 0b0000_0001
            INDEX_2    = 0b0000_0010
            INDEX_3    = 0b0000_0011
            INDEX_4    = 0b0000_0100
            INDEX_5    = 0b0000_0101
            INDEX_6    = 0b0000_0110
            INDEX_7    = 0b0000_0111
            INDEX_8    = 0b0000_1000
            INDEX_9    = 0b0000_1001

            MID_INDEX_0      = 0b0000_0000
            MID_INDEX_1      = 0b0000_0100
            MID_INDEX_2      = 0b0001_0000
            MID_INDEX_3      = 0b0001_0100

            INDEX_BACK = 0b0001_0000

            # Indexes for layout DIRECTORY 0x43

            DIRECTORY_INDICIES = [
              MID_INDEX_0 | BLOCK | FLUSH,
              MID_INDEX_1 | BLOCK | SELECTED,
              MID_INDEX_2 | BLOCK,
              MID_INDEX_3
            ].freeze

            # Indexes for layout SMS_INDEX 0xf0

            INDEX_OUTLIER = 0b1_0011

            INDEX_SMS_INDEX = [
              INDEX_0,
              INDEX_1,
              INDEX_2,
              INDEX_3,
              INDEX_4,
              INDEX_5,
              INDEX_6,
              INDEX_7,
              INDEX_8,
              INDEX_9,
              INDEX_BACK,
              INDEX_OUTLIER
            ].freeze

            SMS_INDEX_INDICIES = [
              INDEX_0 + BLOCK + FLUSH,
              INDEX_1 + BLOCK,
              INDEX_2 + BLOCK,
              INDEX_3 + BLOCK,
              INDEX_4 + BLOCK,
              INDEX_5 + BLOCK,
              INDEX_6 + BLOCK,
              INDEX_7 + BLOCK,
              INDEX_8 + BLOCK,
              INDEX_9 + BLOCK,
              INDEX_BACK + BLOCK,
              INDEX_OUTLIER + BLOCK
            ].freeze

            # Indexes for layout SMS_SHOW 0xf1

            INDEX_BUTTON_LEFT   = 0b1_0001
            INDEX_BUTTON_RIGHT  = 0b1_0010
            INDEX_BUTTON_CENTRE = 0b1_0011

            INDEX_BUTTONS = [
              INDEX_BUTTON_LEFT   + BLOCK,
              INDEX_BUTTON_RIGHT  + BLOCK,
              INDEX_BUTTON_CENTRE + BLOCK
            ].freeze

            SMS_SHOW_INDICIES = [
              INDEX_0 | BLOCK | FLUSH,
              INDEX_1 | BLOCK,
              INDEX_2 | BLOCK,
              INDEX_3 | BLOCK,
              INDEX_4 | BLOCK,
              INDEX_5 | BLOCK,
              INDEX_BACK | BLOCK,
              INDEX_BUTTON_LEFT   | BLOCK,
              INDEX_BUTTON_RIGHT  | BLOCK,
              INDEX_BUTTON_CENTRE | BLOCK
            ].freeze

            LAYOUT_INDICES = {
              LAYOUT_DIRECTORY => DIRECTORY_INDICIES,
              LAYOUT_TOP_8     => DIRECTORY_INDICIES,
              LAYOUT_SMS_INDEX => SMS_INDEX_INDICIES,
              LAYOUT_SMS_SHOW  => SMS_SHOW_INDICIES
            }.freeze

            # PARAMETER 4 Chars

            NO_CHARS = ''
          end
        end
      end
    end
  end
end
