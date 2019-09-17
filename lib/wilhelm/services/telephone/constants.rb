# frozen_string_literal: true

module Wilhelm
  module Services
    class Telephone
      # Services::Telephone::Constants
      module Constants
        TEL = 'Telephone'

        TEL_STATE_DISABLED = 'Disabled'
        TEL_STATE_PENDING  = 'Pending'
        TEL_STATE_OFF      = 'Off'
        TEL_STATE_ON       = 'On'

        TEL_DISABLED = "Telephone (#{TEL_STATE_DISABLED})"
        TEL_PENDING  = "Telephone (#{TEL_STATE_PENDING})"
        TEL_OFF      = "Telephone (#{TEL_STATE_OFF})"
        TEL_ON       = "Telephone (#{TEL_STATE_ON})"

        TEL_CONTROLS = 'Telephone Controls'

        PROG = 'Services::Telephone'
      end
    end
  end
end
