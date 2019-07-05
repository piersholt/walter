# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Dial Telephone Number
          module Dial
            include API
            include Constants

            def open_dial
              logger.unknown(PROC) { '#open_dial()' }
              draw_21(layout: LAYOUT_DIAL, m2: M2_DEFAULT, m3: M3_NIL, chars: CHARS_EMPTY)
            end

            def dial_clear
              clear_digits
              draw_23(gfx: DIAL_CLEAR, chars: STRING_EMPTY)
            end

            def dial_number(digit = '0')
              add_digit(digit)
              draw_23(gfx: DIAL_DIGIT, chars: digits_buffer)
            end

            def dial_number_remove
              remove_digit
              draw_23(gfx: DIAL_DIGIT, chars: digits_buffer)
            end

            private

            def add_digit(digit)
              digits_buffer << digit
            end

            def remove_digit
              digits_buffer.chop!
            end

            def clear_digits
              digits_buffer.clear
            end

            def digits_buffer
              @digits_buffer ||= EMPTY_STRING.dup
            end
          end
        end
      end
    end
  end
end
