# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Wilhelm::Helpers::Parse
    module Parse
      # @param Array<Integer> integers [1, 2, 3, 4]
      # @return Bytes [1, 2, 3, 4]
      def integers_to_byte_array(*integers)
        byte_array = integers.map do |i|
          Wilhelm::Core::Byte.new(i)
        end
        Core::Bytes.new(byte_array)
      end

      alias bytes integers_to_byte_array
      # BMBT::UserControls::UserControls
      alias integers_input bytes

      # @param String string "C8 04 BF 02 38 49"
      # Valid hex representations: C8, 0xC8, C8H
      # @return String [0xC8, 0x04, 0xBF, 0x02, 0x38, 0x49]
      def hex_string_to_string(string)
        string
          &.split
          &.map { |c| c.to_i(16) }
          &.map(&:chr)
          &.join
      end

      alias s2s hex_string_to_string
      alias h2s hex_string_to_string

      # Radio::Capabilities::CDChangerDisplay
      def integer_array_to_chars(array)
        array.map(&:chr).join
      end
    end
  end
end
