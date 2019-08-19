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
              draw_23(gfx: DIAL_CLEAR, chars: STRING_BLANK)
            end

            def recent_contact(contact = generate_last_number)
              draw_23(gfx: DIAL_DIGIT, chars: contact)
            end

            private

            def generate_last_number
              "+614#{Array.new(8) { Random.rand(0..9) }.join}"
            end
          end
        end
      end
    end
  end
end
