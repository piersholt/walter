# frozen_string_literal: false

require_relative 'pending/states'

module Wilhelm
  module Services
    class Manager
      # Manager::Pending
      class Pending
        include Logging
        include Defaults
        include States

        def initialize(context)
          logger.debug(MANAGER_PENDING) { '#initialize' }
          Wilhelm::API::Telephone.instance.disconnected
          # Note: this is a request
          context.devices?
          context.register_controls(Wilhelm::API::Controls.instance)
        end
      end
    end
  end
end
