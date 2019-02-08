# frozen_string_literal: true

module Capabilities
  module Radio
    # Comment
    module Constants
      ZERO = 0x00

      LAYOUT_MENU_A = 0x6_0 # SIMPLE MENU
      LAYOUT_MENU_B = 0x6_1 # MENU WITH HEADER
      LAYOUT_HEADER = 0x6_2

      PADDING_ZERO = 0x00
      PADDING_NONE = 0x01

      NO_INDEX = 0x00

      NO_CHARS = ''
      CLEAR_CHARS = Array.new(20) { ' ' }.join

      LENGTH_TITLE = 11
      LENGTH_SUBHEADING = 20
      LENGTH_A = 5
      LENGTH_B = 7

      INDEX_FIELD_1 = 0b0001
      INDEX_FIELD_2 = 0b0010
      INDEX_FIELD_3 = 0b0011
      INDEX_FIELD_4 = 0b0100
      INDEX_FIELD_5 = 0b0101
      INDEX_FIELD_6 = 0b0110
      INDEX_FIELD_7 = 0b0111

      INDEX_ITEM_0 = 0x4_0
      INDEX_ITEM_1 = 0x4_1
      INDEX_ITEM_2 = 0x4_2
      INDEX_ITEM_3 = 0x4_3
      INDEX_ITEM_4 = 0x4_4
      INDEX_ITEM_5 = 0x4_5
      INDEX_ITEM_6 = 0x4_6
      INDEX_ITEM_7 = 0x4_7
      INDEX_ITEM_8 = 0x4_8
      INDEX_ITEM_9 = 0x4_9
      INDEX_ITEM_10 = 0x4_a

      FLUSH = 0x20
      BLOCK = 0x40

      # HEADER
      FIELD_INDEXES =
        [INDEX_FIELD_1, INDEX_FIELD_2, INDEX_FIELD_3, INDEX_FIELD_4,
         INDEX_FIELD_5, INDEX_FIELD_6, INDEX_FIELD_7].freeze
      FIELD_NEW_INDEXES =
        [INDEX_ITEM_1, INDEX_ITEM_2, INDEX_ITEM_3,
         INDEX_ITEM_4, INDEX_ITEM_5, INDEX_ITEM_6 - BLOCK].freeze

      # MENU
      ITEM_INDEXES =
        [INDEX_ITEM_0 + FLUSH, INDEX_ITEM_1, INDEX_ITEM_2, INDEX_ITEM_3,
         INDEX_ITEM_4, INDEX_ITEM_5, INDEX_ITEM_6, INDEX_ITEM_7,
         INDEX_ITEM_8, INDEX_ITEM_9, INDEX_ITEM_10 - BLOCK].freeze

      LAYOUT_INDICES = {
        0x60 => ITEM_INDEXES,
        0x61 => ITEM_INDEXES,
        0x62 => FIELD_NEW_INDEXES,
        0x63 => [0x61, 0x42, 0x43, 0x44, 0x05]
      }.freeze

    # def rii
    #   index = Random.rand(0..(ITEM_INDEXES.length - 1))
    #   ITEM_INDEXES[index]
    # end
    #
    # def rfi
    #   index = Random.rand(0..(FIELD_INDEXES.length - 3))
    #   FIELD_INDEXES[index]
    # end

    # def index(id, block = false, flush = false)
    #   return id unless block || flush
    #   result = id + 0b0100_0000 if block
    #   result = id + 0b0100_0000 if flush
    #   result
    # end
    end
  end
end
