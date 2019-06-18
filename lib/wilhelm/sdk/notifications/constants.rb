# frozen_string_literal: true

# Top level namespace
module Wilhelm::SDK
  # Default Wilhelm logger
  module Constants
    include LogActually::ErrorOutput

    NOTIFICATIONS = 'Notifications'
    NOTIFICATIONS_LISTENER = 'Notif. Listener'
    NOTIFICATIONS_INACTIVE = 'Notif. (Inactive)'
    NOTIFICATIONS_ACTIVE = 'Notif. (Active)'

    def logger
      LogActually.context
    end
  end
end
