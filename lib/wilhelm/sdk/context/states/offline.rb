# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Wilhelm Service Offline State
        class Offline
          include Defaults
          include Logging

          def online!(context)
            logger.debug(WILHELM_OFFLINE) { '#online' }
            context.change_state(Online.new)

            context.notifications!
            context.ui!
            context.register_controls(Wilhelm::API::Controls.instance)
          end
        end
      end
    end
  end
end