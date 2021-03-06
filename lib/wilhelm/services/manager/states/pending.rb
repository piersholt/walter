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
          # Note: this is a request
          context.devices?
        end
      end
    end
  end
end
