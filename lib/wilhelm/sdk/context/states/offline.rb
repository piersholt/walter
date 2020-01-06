# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Wilhelm Service Offline State
        class Offline
          include Defaults
          include Logging

          def initialize(context)
            logger.debug(WILHELM_OFFLINE) { '#initialize' }
            logger.info(WILHELM_OFFLINE) { 'Stop Notifications' }
            context.notifications&.stop
          end

          def online!(context)
            logger.debug(WILHELM_OFFLINE) { '#online!' }
            context.change_state(Online.new(context))
          end
        end
      end
    end
  end
end
