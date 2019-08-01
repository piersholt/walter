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
          end
        end
      end
    end
  end
end
