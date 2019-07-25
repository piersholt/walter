# frozen_string_literal: false

require_relative 'enabled/notifications'
require_relative 'enabled/states'

module Wilhelm
  module Services
    class Manager
      # Manager::Enabled
      class Enabled
        include Logging
        include Defaults
        include States
        include Notifications

        def initialize(context)
          logger.debug(MANAGER_ENABLED) { '#initialize' }
          Wilhelm::API::Telephone.instance.disconnected
          # Note: this is a request
          context.devices?
          context.register_controls(Wilhelm::API::Controls.instance)
        end
      end
    end
  end
end
