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
        # Services
        context.manager!
        context.audio!
        # Application Context
        context.notifications!
        context.ui!
        context.register_controls(Vehicle::Controls.instance)
        # context.alive?
      end

      def offline!(___)
        logger.debug(WOLFGANG_OFFLINE) { '#offline' }
        logger.warn(WOLFGANG_OFFLINE) { 'State is already Offline!' }
      end
    end
  end
end
