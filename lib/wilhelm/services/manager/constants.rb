# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Default Wilhelm logger
      module Constants
        MANAGER = 'Manager'

        MANAGER_STATE_DISABLED = 'Disabled'
        MANAGER_STATE_PENDING  = 'Pending'
        MANAGER_STATE_ON       = 'On'

        MANAGER_DISABLED = "Manager (#{MANAGER_STATE_DISABLED})"
        MANAGER_PENDING  = "Manager (#{MANAGER_STATE_PENDING})"
        MANAGER_ON       = "Manager (#{MANAGER_STATE_ON})"

        MANAGER_CONTROLS = 'Manager Controls'

        UNKNOWN_DEVICE = 'Unknown Device'
      end
    end
  end
end
