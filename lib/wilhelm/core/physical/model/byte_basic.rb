# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class ByteBasic
      include Wilhelm::Helpers::DataTools

      TYPES = %i[char integer hex].freeze

      attr_reader :value

      def initialize(value, type = :char)
        validate(value, type)
        @value = parse(value, type)
      end

      # Object

      # @override Object#to_s
      def to_s
        inspect
      end

      # @override Object#inspect
      def inspect
        to_h(false)
      end

      # @override Object#eql?
      def eql?(other_value)
        value == other_value.value
      end

      def >(comparison_value)
        value > comparison_value
      end

      def <(comparison_value)
        value < comparison_value
      end

      # @override Object#<==>
      def <=>(other_byte)
        value <=> other_byte.value
      end

      # ACCESSORS

      def to_h(prefix = false)
        d2h(value, prefix)
      end

      def to_i
        value
      end

      def to_b(nibbles = false, prefix = false)
        d2b(value, nibbles, prefix)
      end

      private

      def validate(value, type)
        fail ArgumentError, 'One valid data type required' unless TYPES.include?(type)

        case type
        when :char
          fail ArgumentError, 'Incorrect Encoding' unless value.encoding == Encoding::ASCII_8BIT
          fail ArgumentError, 'Length greater than 1' if value.length > 1
        when :integer
          fail ArgumentError, 'Length greater than 255' if value > 255
        when :hex
          fail ArgumentError, 'Length greater than 2' if value.length > 2
        else
          raise StandardError, "errr, no valid type to validate? type is #{type}"
        end
      end

      def parse(value, type)
        case type
        when :char
          encoded_to_decimal(value)
        when :integer
          value
        when :hex
          hex_to_decimal(value)
        else
          raise StandardError, 'errr, no valid type to parse?'
        end
      end

      alias_method(:i, :to_i)
      alias_method(:h, :to_h)
      alias_method(:b, :to_b)

      alias_method(:d, :to_i)
      alias_method(:to_d, :to_i)
    end
  end
end
