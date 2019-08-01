# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Radio::Capabilities::Constants
          module Constants
            ZERO = 0x00

            # PARAMETER 1: LAYOUT
            LAYOUT_SMS_INDEX = 0xf_0
            LAYOUT_SMS_SHOW  = 0xf_1

            # PARAMETER 2: PADDING
            PADDING_ZERO = 0x00

            PADDING_NONE = 0x01

            # PARAMETER 3: ZONE
            INDEX_ZERO = 0x00

            FLUSH = 0b0010_0000
            BLOCK = 0b0100_0000

            INDEX_0  = 0b0_0000
            INDEX_1  = 0b0_0001
            INDEX_2  = 0b0_0010
            INDEX_3  = 0b0_0011
            INDEX_4  = 0b0_0100
            INDEX_5  = 0b0_0101
            INDEX_6  = 0b0_0110
            INDEX_7  = 0b0_0111
            INDEX_8  = 0b0_1000
            INDEX_9  = 0b0_1001

            INDEX_BACK = 0b1_0000

            # SMS Index 0xf0
            # Select on layout 0xf0
            SELECTED = 0b1000_0000

            INDEX_OUTLIER = 0b1_0011

            SMS_INDEX_INDICIES = [
              INDEX_0 + BLOCK + FLUSH,
              INDEX_1 + BLOCK,
              INDEX_2 + BLOCK + SELECTED,
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

            # SMS Show 0xf1
            # Flash on layout 0xf1
            FLASH = 0b1000_000

            INDEX_BUTTON_LEFT = 0b1_0001
            INDEX_BUTTON_RIGHT = 0b1_0010
            INDEX_BUTTON_CENTRE = 0b1_0011

            SMS_SHOW_INDICIES = [
              INDEX_0 + BLOCK + FLUSH,
              INDEX_1 + BLOCK,
              INDEX_2 + BLOCK,
              INDEX_3 + BLOCK,
              INDEX_4 + BLOCK,
              INDEX_5 + BLOCK,
              INDEX_BACK + BLOCK,
              INDEX_BUTTON_LEFT + BLOCK,
              INDEX_BUTTON_RIGHT + BLOCK,
              INDEX_BUTTON_CENTRE + BLOCK
            ].freeze

            LAYOUT_INDICES = {
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
