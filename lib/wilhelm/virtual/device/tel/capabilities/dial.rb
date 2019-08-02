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
              # @note redraw dial buffer if available?
              # draw_23(gfx: DIAL_DIGIT, chars: dial_buffer) if dial_buffer?
            end

            def dial_clear
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def dial_flush
              clear_dial_buffer
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def dial_number(digit = '0')
              add_dial_digit(digit)
              draw_23(gfx: DIAL_DIGIT, chars: dial_buffer)
            end

            def dial_delete
              remove_dial_digit
              draw_23(gfx: DIAL_DIGIT, chars: dial_buffer)
            end

            private

            def add_dial_digit(digit)
              dial_buffer << digit
            end

            def remove_dial_digit
              dial_buffer.chop!
            end

            def clear_dial_buffer
              dial_buffer.clear
            end

            def dial_buffer?
              !dial_buffer.empty?
            end

            def dial_buffer
              @dial_buffer ||= STRING_BLANK.dup
            end
          end
        end
      end
    end
  end
end
