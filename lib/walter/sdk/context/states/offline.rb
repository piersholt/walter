# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class ApplicationContext
    # Wolfgang Service Offline State
    class Offline
      include Defaults
      include Constants

      def online!(context)
        logger.debug(WOLFGANG_OFFLINE) { '#online' }
        context.change_state(Online.new)
        
        context.notifications!
        context.ui!
        context.register_controls(Vehicle::Controls.instance)
      end
    end
  end
end
