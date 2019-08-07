# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # SOS
          module SOS
            include API
            include Constants

            MOD_PROG = 'SOS'
            DEFAULT_SOS = 'SOS: 112!'

            def open_sos
              logger.unknown(MOD_PROG) { '#open_sos()' }
              draw_23(gfx: DEFAULT_TITLE, chars: DEFAULT_SOS)
            end
          end
        end
      end
    end
  end
end
