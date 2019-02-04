# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Default Wolfgang logger
  module Logger
    include LogActually::ErrorOutput

    WOLFGANG = 'Wolfgang'
    WOLFGANG_OFFLINE = 'Wolfgang (Offline)'
    WOLFGANG_EST = 'Wolfgang (Est.)'
    WOLFGANG_ONLINE = 'Wolfgang (Online)'

    NOTIFICATIONS = 'Notifications'
    NOTIFICATIONS_LISTENER = 'Notif. Listener'
    NOTIFICATIONS_INACTIVE = 'Notif. (Inactive)'
    NOTIFICATIONS_ACTIVE = 'Notif. (Active)'

    MANAGER = 'Mananger'
    MANAGER_ENABLED = 'Mananger (Enabled)'
    MANAGER_ON = 'Mananger (On)'

    AUDIO = 'Audio'
    AUDIO_ENABLED = 'Audio (Enabled)'
    AUDIO_ON = 'Audio (On)'

    def logger
      LogActually.wolfgang
    end
  end
end
