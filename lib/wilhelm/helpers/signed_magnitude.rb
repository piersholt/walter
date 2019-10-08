# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Signed magnitude representation (SMR)
    # BMBT LCD brightness control has values -10 through 10 as indicated
    # via Service Mode. These values appear to be SMR.
    class SignedMagnitude
      include Wilhelm::Helpers::Bitwise

      BITMASK_SIGN      = 0b1000_0000
      BITMASK_MAGNITUDE = 0b0111_1111

      attr_reader :value

      def parse(smr)
        validate_smr(smr)
        sign = bitwise_all?(smr, BITMASK_SIGN)
        magnitude = bitwise_and(smr, BITMASK_MAGNITUDE)
        @value = magnitude
        @value *= -1 if sign
        self
      end

      def generate(int)
        validate_int(int)
        @value = 0
        @value = bitwise_xor(@value, BITMASK_SIGN) unless int.positive?
        @value = bitwise_xor(@value, int.abs)
        self
      end

      # @param SignedMagnitude smr
      # @return Integer
      def self.parse(smr)
        new.parse(smr)&.value
      end

      # @param Integer int
      # @return SignedMagnitude
      def self.generate(int)
        new.generate(int)&.value
      end

      private

      def validate_smr(smr)
        return true if (0x00..0xff).cover?(smr)
        raise(ArgumentError, "Range error: #{smr}")
      end

      def validate_int(int)
        return true if (-127..127).cover?(int)
        raise(ArgumentError, "Range error: #{int}")
      end
    end
  end
end
