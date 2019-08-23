# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone Top 8 Contacts
          module Top8
            include API
            include Constants

            MOD_PROG = 'Top 8'

            def top_8_name(name = 'MUM')
              draw_23(gfx: TOP_8_NAME, chars: name)
            end

            def top_8_number(number = '98764321')
              draw_23(gfx: TOP_8_NUMBER, chars: number)
            end

            def top_8_clear
              draw_23(gfx: TOP_8_CLEAR, chars: STRING_BLANK)
            end

            def top_8_contact_list(*contacts)
              macro_mid(LAYOUT_TOP_8, FUNCTION_CONTACT, contacts)
            end
          end
        end
      end
    end
  end
end
