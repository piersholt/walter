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
              draw_21(layout: LAYOUT_DIAL, m2: FUNCTION_DIGIT, m3: M3_FLUSH, chars: CHARS_EMPTY)
            end

            def dial_clear
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def dial_number(digits = dial_buffer)
              # add_dial_digit(digit)
              draw_23(gfx: DIAL_DIGIT, chars: digits)
            end
          end
        end
      end
    end
  end
end
