# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone Top 8 Contacts
          module Directory
            include API
            include Constants

            MOD_PROG = 'Directory'

            def open_directory
              draw_21(layout: LAYOUT_DIRECTORY, m2: FUNCTION_CONTACT, m3: M3_FLUSH, chars: CHARS_EMPTY)
            end

            def directory_name(name = 'MUM')
              draw_23(gt: DIRECTORY_CONTACT_NAME, chars: name)
            end

            def directory_number(number = '98764321')
              draw_23(gt: DIRECTORY_CONTACT_NUMBER, chars: number)
            end

            def directory_clear
              draw_23(gt: DIRECTORY_CLEAR, chars: STRING_BLANK)
            end

            def prep
              LIMIT_DIRECTORY
            end

            def directory_contact_list(*contacts)
              macro_mid(LAYOUT_DIRECTORY, FUNCTION_CONTACT, contacts)
              # directory_clear
            end
          end
        end
      end
    end
  end
end
