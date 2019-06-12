# frozen_string_literal: true

# Top level namespace
module Wilhelm
  class ApplicationContext
    # Wilhelm Service Offline State
    class Offline
      include Defaults
      include Constants

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
