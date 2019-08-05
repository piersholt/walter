# frozen_string_literal: false

require_relative 'bit_array/parse'

module Wilhelm
  module Core
    # Virtual::BitArray
    class BitArray
      extend Forwardable
      include Wilhelm::Helpers::DataTools
      include Parse

      PROG = 'BitArray'.freeze

      DELIMITER = ' '.freeze
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
          case bit
          when 0
            as_false(bit)
          when 1
            as_true(bit)
          end
        end

        i = 4
        while i < mapped_bits.length
          mapped_bits.insert(i, DELIMITER)
          i += 5
        end

        mapped_bits.join
      end

      private

      def as_false(bit)
        as_colour(bit, ASCII_RED)
      end

      def as_true(bit)
        as_colour(bit, ASCII_GREEN)
      end

      def as_colour(string, colour_id)
        "\33[#{colour_id}m" \
        "#{string}" \
        "\33[0m"
      end
    end
  end
end
