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

            # HEADER
            HEADER_INDEXES = [
              INDEX_1 + BLOCK,
              INDEX_2 + BLOCK,
              INDEX_3 + BLOCK,
              INDEX_4 + BLOCK,
              INDEX_5 + BLOCK,
              INDEX_6 + BLOCK,
              INDEX_7
            ].freeze

            # MENU
            MENU_INDEXES = [
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
              INDEX_10 + BLOCK
            ].freeze

            # MENU (Static)
            LINE_INDEXES = [
              INDEX_1 + BLOCK + FLUSH,
              INDEX_2 + BLOCK,
              INDEX_3 + BLOCK,
              INDEX_4 + BLOCK,
              INDEX_5
            ].freeze

            LAYOUT_INDICES = {
              LAYOUT_MENU_A => MENU_INDEXES,
              LAYOUT_MENU_B => MENU_INDEXES,
              LAYOUT_HEADER => HEADER_INDEXES,
              LAYOUT_STATIC => LINE_INDEXES
            }.freeze
          end
        end
      end
    end
  end
end
