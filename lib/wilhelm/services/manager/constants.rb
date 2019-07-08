# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Default Wilhelm logger
      module Constants
        MANAGER = 'Mananger'

        MANAGER_STATE_DISABLED = 'Disabled'
        MANAGER_STATE_ENABLED  = 'Pending'
        MANAGER_STATE_ON       = 'On'

        MANAGER_DISABLED = "Mananger (#{MANAGER_STATE_DISABLED})"
        MANAGER_ENABLED  = "Mananger (#{MANAGER_STATE_ENABLED})"
        MANAGER_ON       = "Mananger (#{MANAGER_STATE_ON})"

        MANAGER_CONTROLS = 'Mananger Controls'
      end
    end
  end
end
