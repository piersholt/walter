# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::Default
          module Default
            include API
            include Constants

            MOD_PROG = 'Default'
            TITLE_DEFAULT = 'Default Title'

            def open_default
              logger.unknown(MOD_PROG) { '#open_default()' }
              draw_23(to: :gfx, gfx: DEFAULT_TITLE, chars: TITLE_DEFAULT)
            end
          end
        end
      end
    end
  end
end
