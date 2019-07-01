# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone Last Dialed Numbers
          module LastNumbers
            include API
            include Constants

            def recent_clear
              primary(gfx: DIAL_CLEAR, chars: CHARS_EMPTY)
            end

            def recent_contact(contact = '+61400111222')
              primary(gfx: DIAL_DIGIT, chars: contact)
            end
          end
        end
      end
    end
  end
end
