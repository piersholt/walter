# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Bitwise Operations
    module Bitwise
      def bitwise_or(*bitmasks)
        bitmasks.reduce(:|)
      end

      def bitwise_xor(*bitmasks)
        bitmasks.reduce(:^)
      end

      def bitwise_and(*bitmasks)
        bitmasks.reduce(:&)
      end

      # One or more bits match
      def bitwise_on?(bitfield, *bitmasks)
        bitmask = bitwise_or(*bitmasks)
        bitwise_and(bitfield, bitmask) != 0
      end

      alias bitwise_any? bitwise_on?

      # All bit match
      def bitwise_all?(bitfield, *bitmasks)
        bitmask = bitwise_or(*bitmasks)
        bitwise_and(bitfield, bitmask) == bitmask
      end
    end
  end
end
