# frozen_string_literal: true

module Wilhelm
  module Services
    # Bluetooth Device Manager
    class Manager
      include Observable
      include Logging
      include State
      include Properties
      include Notifications
      include Actions
      include Requests
      include Replies
      include Context
      include Messaging::API

      attr_reader :state

      def initialize
        @state = Disabled.new
      end
    end
  end
end
