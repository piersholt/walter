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
              draw_23(gfx: DIAL_CLEAR, chars: STRING_EMPTY)
            end

            def recent_contact(contact = '+61400111222')
              draw_23(gfx: DIAL_DIGIT, chars: contact)
            end
          end
        end
      end
    end
  end
end
