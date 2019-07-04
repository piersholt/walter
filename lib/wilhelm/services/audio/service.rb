# frozen_string_literal: true

module Wilhelm
  module Services
    # Bluetooth Audio Streaming
    class Audio
      include Observable
      include Logging
      include Properties
      include State
      include Notifications
      include Controls
      include Actions
      include Requests
      include Replies
      include Context
      include Messaging::API

      def initialize
        @state = Disabled.new
      end
    end
  end
end
