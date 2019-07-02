# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      # Default Wilhelm logger
      module Constants
        include LogActually::ErrorOutput

        NOTIFICATIONS = 'Notifications'
        NOTIFICATIONS_LISTENER = 'Notif. Listener'
        NOTIFICATIONS_INACTIVE = 'Notif. (Inactive)'
        NOTIFICATIONS_ACTIVE = 'Notif. (Active)'

        def logger
          LOGGER
        end
      end
    end
  end
end
