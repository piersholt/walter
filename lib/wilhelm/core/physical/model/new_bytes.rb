# frozen_string_literal: true

module Wilhelm
  module Core
    # Core::Bytes
    class Bytes
      extend Forwardable

      MASK_HEX = '%2.2X'
      DELIMITER = ' '
      VALID_TYPES = [Wilhelm::Core::Bytes, Array].freeze
      VALID_ELEMENTS = [Byte, Integer].freeze

      def_delegators(
        :array,
        *Array.instance_methods(false),
        *Enumerable.instance_methods
      )
      alias wholesale replace

      attr_reader :array

      def initialize(array = [])
        validate_array(array)
        @array = array
      end

      def to_s
        array.map { |i| Kernel.format(MASK_HEX, i) }&.join(DELIMITER)
      end

      # For writing to IO
      def generate
        array.map { |i| i.chr(Encoding::ASCII_8BIT) }&.join
      end

      alias as_string generate

      def validate_array(array)
        valid_type?(array)
        valid_elements?(array)
      end

      def valid_type?(array)
        return true if VALID_TYPES.any? { |t| array.is_a?(t) }
        raise(
          ArgumentError,
          "Bytes.new(): object must be Array. Argument is type: #{array.class}."
        )
      end

      def valid_elements?(array)
        return true if array.all? { |i| VALID_ELEMENTS.any? { |t| i.is_a?(t) } }
        raise(
          ArgumentError,
          'Bytes.new(): Array elements must be Byte. ' \
          "Element types are: #{array.map(&:class).uniq}."
        )
      end
    end
  end
end
