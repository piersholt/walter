# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class Services
        # Context::Services::Constants
        module Constants
          include LogActually::ErrorOutput

          WILHELM = 'Wilhelm'
          WILHELM_OFFLINE = 'Wilhelm (Offline)'
          WILHELM_EST = 'Wilhelm (Est.)'
          WILHELM_ONLINE = 'Wilhelm (Online)'

          PING_INTERVAL = 30
        end
      end
    end
  end
end
