# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Radio::Capabilities::Constants
          module Constants
            ZERO = 0x00
            NO_PADDING = 0x00
            NO_INDEX = 0x00
            NO_CHARS = ''

            LAYOUT_MENU_A = 0x6_0 # SIMPLE MENU
            LAYOUT_MENU_B = 0x6_1 # MENU WITH HEADER
            LAYOUT_HEADER = 0x6_2
            LAYOUT_STATIC = 0x6_3

            PADDING_NONE = 0x01

            INDEX_0  = 0b0000
            INDEX_1  = 0b0001
            INDEX_2  = 0b0010
            INDEX_3  = 0b0011
            INDEX_4  = 0b0100
            INDEX_5  = 0b0101
            INDEX_6  = 0b0110
            INDEX_7  = 0b0111
            INDEX_8  = 0b1000
            INDEX_9  = 0b1001
            INDEX_10 = 0b1010

            FLUSH = 0b0010_0000
            BLOCK = 0b0100_0000

            SELECTED   = 0b1000_0000

            # HEADER
            HEADER_INDICES = [
              INDEX_1,
              INDEX_2,
              INDEX_3,
              INDEX_4,
              INDEX_5,
              INDEX_6,
              INDEX_7
            ].freeze

            # MENU
            MENU_INDICES = [
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
              INDEX_10
            ].freeze

            # MENU (Static)
            LINE_INDICES = [
              INDEX_1,
              INDEX_2,
              INDEX_3,
              INDEX_4,
              INDEX_5
            ].freeze

            LAYOUT_INDICES = {
              LAYOUT_MENU_A => MENU_INDICES,
              LAYOUT_MENU_B => MENU_INDICES,
              LAYOUT_HEADER => HEADER_INDICES,
              LAYOUT_STATIC => LINE_INDICES
            }.freeze
          end
        end
      end
    end
  end
end
