# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Telephone::Capabilities::SMS
            module SMS
              include Constants

              MOD_PROG = 'Mock::SMS'
              LIMIT_SMS = 10

              def generate_sms_index
                items = LAYOUT_INDICES[LAYOUT_SMS_INDEX].collect do |index|
                  format_21(LAYOUT_SMS_INDEX, FUNCTION_SMS, index, 3)
                end
                messages_index(*items)
              end

              def generate_sms_show
                items = LAYOUT_INDICES[LAYOUT_SMS_SHOW].collect.with_index do |index, i|
                  chars = format_21(
                    LAYOUT_SMS_SHOW,
                    FUNCTION_SMS,
                    index,
                    "Line #{i}"
                  )

                  case index
                  when INDEX_BACK | BLOCK
                    chars = 1.chr
                  when INDEX_BUTTON_LEFT | BLOCK
                    chars = 'Left'
                  when INDEX_BUTTON_RIGHT | BLOCK
                    chars = 'Right'
                  when INDEX_BUTTON_CENTRE | BLOCK
                    chars = 'Centre'
                  end

                  chars
                end

                macro_detail(LAYOUT_SMS_SHOW, FUNCTION_SMS, items, 'SMS Message')
              end
            end
          end
        end
      end
    end
  end
end
