# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::SOS
          module SOS
            include API
            include Constants

            DEGREES = 0xb0.chr

            MOD_PROG = 'SOS'
            DEFAULT_SOS = 'SOS: 112!'

            LINES = [
              'Your current position is:',
              'MELBOURNE, VIC',
              'COLLINS ST;',
              '',
              "37#{DEGREES} 48' 51.6\" South",
              "144#{DEGREES} 58' 14.5\" East"
            ].freeze

            def open_sos
              logger.unknown(MOD_PROG) { '#open_sos' }

              LAYOUT_INDICES[LAYOUT_SMS_SHOW].each.with_index do |i, index|
                chars = LINES.fetch(index, nil)
                next unless chars
                draw_row_21(LAYOUT_SMS_SHOW, FUNCTION_SOS, i, chars)
              end

              draw_row_21(
                LAYOUT_SMS_SHOW, FUNCTION_SOS,
                (INDEX_BACK | BLOCK), 'Back'
              )
              draw_row_21(
                LAYOUT_SMS_SHOW, FUNCTION_SOS,
                (INDEX_BUTTON_CENTRE | BLOCK), 'SOS'
              )
              header(
                layout: LAYOUT_SMS_SHOW, padding: 0x00,
                zone: 0x00, chars: DEFAULT_SOS
              )
            end
          end
        end
      end
    end
  end
end
