# frozen_string_literal: true

require_relative 'sms/display'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::SMS
          module SMS
            include Display
            include Constants

            MOD_PROG = 'SMS'
            LIMIT_SMS = 10

            def generate_sms_index
              LAYOUT_INDICES[LAYOUT_SMS_INDEX].each do |index|
                chars = format_21(LAYOUT_SMS_INDEX, LAYOUT_SMS_INDEX, index, 3)
                m2 = index == INDEX_BACK | BLOCK ? FUNCTION_NAVIGATE : LAYOUT_SMS_INDEX
                draw_21(
                  layout: LAYOUT_SMS_INDEX,
                  m2: m2,
                  m3: index,
                  chars: chars
                )
              end
              header(layout: LAYOUT_SMS_INDEX, chars: 'SMS Index')
            end

            def generate_sms_show
              LAYOUT_INDICES[LAYOUT_SMS_SHOW].each.with_index do |index, i|
                chars = format_21(
                  LAYOUT_SMS_SHOW,
                  LAYOUT_SMS_INDEX,
                  index,
                  "Line #{i}"
                )

                case index
                when INDEX_BACK | BLOCK
                  chars = 1.chr
                when INDEX_BUTTON_LEFT | BLOCK
                  chars = 'LEFT'
                when INDEX_BUTTON_RIGHT | BLOCK
                  chars = 'RIGHT'
                when INDEX_BUTTON_CENTRE | BLOCK
                  chars = 'CENTRE'
                end

                draw_21(
                  layout: LAYOUT_SMS_SHOW,
                  m2: LAYOUT_SMS_INDEX,
                  m3: index,
                  chars: chars
                )
              end
              header(
                layout: LAYOUT_SMS_SHOW,
                chars: format_a5(LAYOUT_SMS_SHOW, LAYOUT_SMS_INDEX, 0, 'Title')
              )
            end
          end
        end
      end
    end
  end
end
