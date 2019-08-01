# frozen_string_literal: true

module Wilhelm
  module Services
    # Bluetooth Device Manager
    class Manager
      include Wilhelm::Helpers::Observation
      include Logging
      include State
      include Properties
      include Notifications
      include Controls
      include Actions
      include Requests
      include Replies
      include Context
      include Yabber::API

      def initialize
        @state = Disabled.new
        register_controls(Wilhelm::API::Controls.instance)
      end
    end
  end
end
