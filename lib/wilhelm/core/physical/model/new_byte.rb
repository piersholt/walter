# frozen_string_literal: true

module Wilhelm
  module Core
    # Core::Byte
    class Byte
      extend Forwardable

      VALID_RANGE = (0..255)
      ERROR_RANGE = 'Value must be (0..255)'

      def_delegators :value, *Integer.instance_methods(false)

      attr_reader :value

      def initialize(value)
        validate_value(value)
        @value = value
      end

      def chr(encoding = Encoding::ASCII_8BIT)
        value.chr(encoding)
      end

      MASK_MAP = {
        16 => '%2.2x'
      }.freeze

      def to_s(base = 10)
        return value.to_s(base) unless MASK_MAP.key?(base)
        format(MASK_MAP[base], value)
      end

      def validate_value(value)
        valid_range?(value)
      end

      def valid_range?(value)
        return true if VALID_RANGE.cover?(value)
        raise(ArgumentError, ERROR_RANGE)
      end

      alias i itself
      alias h to_s
      alias d itself
      alias e chr

      alias to_i itself
      alias to_h to_s
      alias to_d itself
      alias to_e chr
    end
  end
end

module Wilhelm
  module Core
    # Core::ByteBasic
    # @deprecated
    class ByteBasic < Byte
      def initialize(value, type = false)
        case value
        when String
          super(type, value.bytes.first)
        else
          super(type, value)
        end
      end
    end
  end
end
