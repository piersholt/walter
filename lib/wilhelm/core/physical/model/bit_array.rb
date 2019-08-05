# frozen_string_literal: false

module Wilhelm
  module Core
    # Virtual::BitArray
    class BitArray
      extend Forwardable
      include Wilhelm::Helpers::DataTools

      NIBBLE_1 = (0..3)
      NIBBLE_2 = (4..7)
      BIT_0 = 0
      BIT_1 = 1
      ASCII_RED = 2
      ASCII_GREEN = 92

      ERROR_LENGTH = 'Binary data failure'.freeze

      def_delegators(:@bits, *Array.instance_methods(false))

      include Indexed

      def initialize(bit_array = Array.new(8, 0))
        @bits = bit_array
      end

      # @param value : Integer
      def parse_integer(integer)
        binary_string = d2b(integer)
        parse_string(binary_string)
      end

      def self.from_i(int)
        bit_array = BitArray.new
        bit_array.parse_integer(int)
        bit_array
      end

      # @param String binary_string Binary bit in String format i.e. "01100010"
      def parse_string(binary_string)
        raise(RangeError, ERROR_LENGTH) if binary_string.length > 8
        bit_chars = binary_string.chars
        bit_integers = bit_chars.map(&:to_i)
        @bits = bit_integers
      end

      def to_s
        mapped_bits = @bits.map do |bit|
          if bit == BIT_0
            as_false(bit)
          elsif bit == BIT_1
            as_true(bit)
          end
        end

        nibble_1_string = mapped_bits.slice(NIBBLE_1)&.join
        nibble_2_string = mapped_bits.slice(NIBBLE_2)&.join

        "#{nibble_1_string} #{nibble_2_string}"
      end

      private

      def as_false(bit)
        as_colour(bit, ASCII_RED)
      end

      def as_true(bit)
        as_colour(bit, ASCII_GREEN)
      end

      def as_colour(string, colour_id)
        str_buffer = "\33[#{colour_id}m"
        str_buffer.concat(string.to_s)
        str_buffer.concat("\33[0m")
      end
    end
  end
end
