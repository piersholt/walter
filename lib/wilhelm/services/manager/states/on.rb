# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class On
        include Logging
        include Notifications
        include Actions

        def initialize(context)
          logger.debug(MANAGER_ON) { '#initialize' }
        end

        def disable(context)
          context.change_state(Disabled.new)
        end
      end
    end
  end
end
