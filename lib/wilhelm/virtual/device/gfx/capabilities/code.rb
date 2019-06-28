# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Code/Immobilizer Input
          module Code
            include API
            include Constants

            NIBBLE_SHIFT = 4
            VALID_DIGITS = (0..9)

            # Code 0x0d User input of four digit code
            # @note alias code
            def input_code(*digits)
              b2 = nibbles!(d0, d1)
              b3 = nibbles!(d2, d3)
              obc_var(b1: FIELD_CODE, b2: b2, b3: b3, b4: VAR_NIL)
            end

            alias code input_code

            private

            # Convert a series of nibbles to bytes
            def nibbles!(*nibbles)
              nibbles.reduce(0) { |m, o| (m << NIBBLE_SHIFT) + o }
            end
          end
        end
      end
    end
  end
end
