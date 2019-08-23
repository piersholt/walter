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

            def open_pin(chars = DEFAULT_PIN)
              logger.unknown(MOD_PROG) { '#open_pin()' }
              draw_23(to: :glo_h, gfx: PIN_TITLE, chars: chars)
            end

            def pin_clear
              # clear_pin_buffer
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def pin_number(chars = pin_buffer)
              draw_23(gfx: PIN_TITLE, chars: chars)
            end
          end
        end
      end
    end
  end
end
