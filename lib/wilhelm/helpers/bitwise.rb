# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Bitwise Operations
    module Bitwise
      def bitwise_or(*masks)
        masks.reduce(0) do |m, o|
          m | o
        end
      end

      def bitwise_xor(*masks)
        masks.reduce(0) do |m, o|
          m ^ o
        end
      end

      alias xor bitwise_xor

      def bitwise_on?(mask, mask_on)
        mask & mask_on == mask_on
      end
    end
  end
end
