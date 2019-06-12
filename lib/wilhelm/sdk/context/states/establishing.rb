# frozen_string_literal: true

# Top level namespace
module Wilhelm::SDK
  class ApplicationContext
    # Wilhelm Service Establishing State
    class Establishing
      include Defaults
      include Constants

      def initialize(context)
        logger.debug(WILHELM_EST) { '#initialize' }
        context.register_controls(Wilhelm::API::Controls.instance)
      end

      def close(context)
        logger.debug(WILHELM_EST) { '#close' }
        logger.debug(WILHELM_EST) { 'Stop Notifications' }
        context.notifications&.stop

        logger.debug(WILHELM_EST) { 'Disable Mananger' }
        context.manager&.disable
        logger.debug(WILHELM_EST) { 'Disable Audio' }
        context.audio&.disable

        logger.debug(WILHELM_EST) { 'Disconnect Client.' }
        # Client.disconnect
        context.offline!
      end

      def online!(context)
        context.change_state(Online.new)
        context.manager.enable
        context.notifications!
      end

      def offline!(context)
        context.change_state(Offline.new)
      end

      # Application Context

      def ui!(context)
        logger.debug(WILHELM_EST) { '#ui' }
        context.ui = context.create_ui(context)
        true
      end

      # Services

      # def manager!(context)
      #   logger.debug(WILHELM_EST) { '#manager' }
      #   context.manager = context.create_manager(context)
      #   true
      # end
      #
      # def audio!(context)
      #   logger.debug(WILHELM_EST) { '#audio' }
      #   context.audio = context.create_audio(context)
      #   true
      # end
    end
  end
end
