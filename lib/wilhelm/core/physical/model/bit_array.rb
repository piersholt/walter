# frozen_string_literal: false

require_relative 'bit_array/parse'

module Wilhelm
  module Core
    # Virtual::BitArray
    class BitArray
      extend Forwardable
      include Wilhelm::Helpers::DataTools
      include Parse


      NIBBLE_1 = (0..3)
      NIBBLE_2 = (4..7)
      BIT_0 = 0
      BIT_1 = 1
      ASCII_RED = 2
      ASCII_GREEN = 92

      def self.from_i(object)
        Parse.from_i(object)
      end

      def_delegators(:@bits, *Array.instance_methods(false))

      include Indexed

      def initialize(bit_array = Array.new(8, 0))
        @bits = bit_array
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
