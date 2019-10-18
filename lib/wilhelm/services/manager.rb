# frozen_string_literal: true

require_relative 'manager/constants'
require_relative 'manager/logging'

require_relative 'manager/models/device'
require_relative 'manager/models/devices'

require_relative 'manager/notifications/device_handler'

require_relative 'manager/states/defaults'
require_relative 'manager/states/disabled'
require_relative 'manager/states/pending'
require_relative 'manager/states/on'

require_relative 'manager/state'
require_relative 'manager/properties'
require_relative 'manager/notifications'
require_relative 'manager/actions'
require_relative 'manager/requests'
require_relative 'manager/replies'
require_relative 'manager/controls'
require_relative 'manager/context'

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

# TODO: confirm if Manager is a dependency for UI
require_relative 'manager/ui'
