# frozen_string_literal: true

module Wilhelm
  module Services
    # Bluetooth Audio Streaming
    class Audio
      include Helpers::Observation
      include State
      include Logging
      include Properties
      include Notifications
      include Controls
      include Actions
      include Requests
      include Replies
      include Context

      def initialize
        @state = Disabled.new
        register_controls(Wilhelm::API::Controls.instance)
      end
    end
  end
end
