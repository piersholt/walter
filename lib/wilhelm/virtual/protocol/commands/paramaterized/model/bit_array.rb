# frozen_string_literal: false

module Wilhelm
  module Virtual
    class BitArray
      # Virtual::BitArray::DataError
      class DataError < StandardError
        ERROR_MESSAGE = 'Binary data failure'.freeze

        def message
          ERROR_MESSAGE
        end
      end
    end
  end
end

module Wilhelm
  module Virtual
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

      forward_messages = Array.instance_methods(false)
      forward_messages << :reduce
      forward_messages.each do |fwrd_message|
        def_delegator :@bits, fwrd_message
      end

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
        raise DataError if binary_string.length > 8
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
