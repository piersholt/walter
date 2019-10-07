# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Signed magnitude representation (SMR)
    # BMBT LCD brightness control has values -10 through 10 as indicated
    # via Service Mode. These values appear to be SMR.
    class SignedMagnitude
      extend Forwardable
      include Wilhelm::Helpers::Bitwise

      BITMASK_SIGN      = 0b1000_0000
      BITMASK_MAGNITUDE = 0b0111_1111

      attr_reader :value
      def_delegators :value, *Integer.instance_methods(false)

      def initialize(int)
        validate_value(int)

        sign = bitwise_all?(int, BITMASK_SIGN)
        magnitude = bitwise_and(int, BITMASK_MAGNITUDE)
        @value = magnitude
        @value *= -1 if sign
      end

      def self.parse(int)
        smr = new(int)
        smr.value
      end

      private

      def validate_value(int)
        return true if (0x00..0xff).cover?(int)
        raise(ArgumentError, "Range error: #{int}")
      end
    end
  end
end
