# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # PIN
          module PIN
            include API
            include Constants

            MOD_PROG = 'PIN'
            DEFAULT_PIN = 'PIN-Code eingeben'

            def open_pin
              logger.unknown(MOD_PROG) { '#open_pin()' }
              draw_23(to: :glo_h, gfx: PIN_TITLE, chars: DEFAULT_PIN)
            end

            def pin_clear
              # clear_pin_buffer
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def pin_flush
              clear_pin_buffer
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def pin_number(digit = '0')
              add_pin_digit(digit)
              draw_23(gfx: PIN_TITLE, chars: pin_buffer)
            end

            def pin_delete
              remove_pin_digit
              draw_23(gfx: PIN_TITLE, chars: pin_buffer)
            end

            private

            def add_pin_digit(digit)
              pin_buffer << digit
            end

            def remove_pin_digit
              pin_buffer.chop!
            end

            def clear_pin_buffer
              pin_buffer.clear
            end

            def pin_buffer
              @pin_buffer ||= STRING_BLANK.dup
            end
          end
        end
      end
    end
  end
end
