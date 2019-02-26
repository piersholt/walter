# frozen_string_literal: true

# Comment
module Wolfgang
  class Commands
    # Comment
    class Listener
      include NotificationDelegator
      include Singleton
      include Logger

      def logger
        LogActually.notify
      end

    end
  end
end
