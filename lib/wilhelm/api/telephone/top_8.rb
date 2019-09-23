# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::Top8
      module Top8
        MOD_PROG = 'Telephone::Top8'

        def top_8_contact_list(*contacts)
          bus.tel.top_8_contact_list(*contacts)
        end

        def top_8_name(contact_name)
          bus.tel.top_8_name(contact_name)
        end
      end
    end
  end
end
