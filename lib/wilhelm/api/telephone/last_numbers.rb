# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::LastNumbers
      module LastNumbers
        MOD_PROG = 'Telephone::LastNumbers'

        def recent_contact(contact_name)
          bus.tel.recent_contact(contact_name)
        end
      end
    end
  end
end
