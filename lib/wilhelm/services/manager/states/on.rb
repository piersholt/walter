# frozen_string_literal: true

require_relative 'on/actions'
require_relative 'on/notifications'
require_relative 'on/states'

module Wilhelm
  module Services
    class Manager
      # Manager::On
      class On
        include Logging
        include Defaults
        include States
        include Actions
        include Notifications

        def initialize(*)
          logger.debug(MANAGER_ON) { '#initialize' }
        end
      end
    end
  end
end
