# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class ApplicationContext
    # Wolfgang Service Online State
    class Online
      include Defaults
      include Constants

      def online!(___)
        logger.debug(WOLFGANG_ONLINE) { '#online' }
        logger.warn(WOLFGANG_ONLINE) { 'State is already Online!' }
      end

      def offline!(context)
        logger.debug(WOLFGANG_ONLINE) { '#offline' }
        context.change_state(Offline.new)
        # Application Context
        logger.debug(WOLFGANG_ONLINE) { 'Stop Notifications' }
        context.notifications&.stop

        # Services
        logger.debug(WOLFGANG_ONLINE) { 'Disable Mananger' }
        context.manager&.disable
        logger.debug(WOLFGANG_ONLINE) { 'Disable Audio' }
        context.audio&.disable

        # logger.debug(WOLFGANG_ONLINE) { 'Disconnect Client.' }
        # Client.disconnect
        # logger.debug(WOLFGANG_ONLINE) { 'Disconnect Publisher.' }
        # Publisher.disconnect
        # logger.debug(WOLFGANG_ONLINE) { 'Destroy context.' }
        # Publisher.destroy
        # context.offline!
      end

      # APPLICATION CONTEXT -----------------------------------------------------

      def notifications!(context)
        logger.debug(WOLFGANG_ONLINE) { '#notifications' }
        context.notifications = create_notifications(context)
        true
      end

      def ui!(context)
        logger.debug(WOLFGANG_ONLINE) { '#ui' }
        context.ui = create_ui(context)
        true
      end

      # SERVICES --------------------------------------------------------------

      def manager!(context)
        logger.debug(WOLFGANG_ONLINE) { '#manager' }
        context.manager = create_manager
        true
      end

      def audio!(context)
        logger.debug(WOLFGANG_ONLINE) { '#audio' }
        context.audio = create_audio
        true
      end

      private

      # APPLICATION CONTEXT ---------------------------------------------------

      def create_notifications(context)
        logger.debug(WOLFGANG_ONLINE) { '#create_notifications' }
        notifications = Notifications.new(context)
        # logger.debug(WOLFGANG_ONLINE) { '#notifications.start =>' }
        notifications.start
        # logger.debug(WOLFGANG_ONLINE) { '#notifications' }
        notifications
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def create_ui(context)
        LogActually.ui.debug(WOLFGANG) { "#create_ui (#{Thread.current})" }
        ui_context = Wolfgang::UserInterface::Context.new(context)
        register_service_controllers(ui_context)
        ui_context
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def register_service_controllers(ui_context)
        LogActually.ui.debug(WOLFGANG) do
          "#register_service_controllers (#{Thread.current})"
        end
        ui_context.register_service_controllers(
          header:  Wolfgang::UserInterface::Controller::HeaderController,
          debug:  Wolfgang::UserInterface::Controller::DebugController,
          nodes:  Wolfgang::UserInterface::Controller::NodesController,
          services:  Wolfgang::UserInterface::Controller::ServicesController
        )
        ui_context.register_service_controllers(
          audio:  Wolfgang::UserInterface::Controller::AudioController,
          bluetooth:  Wolfgang::UserInterface::Controller::BluetoothController
        )
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      # SERVICES --------------------------------------------------------------

      def create_audio
        audio = Audio.new
        # audio.disable
        audio
      rescue StandardError => e
        with_backtrace(logger, e)
        :error
      end

      def create_manager
        manager = Manager.new
        # manager.enable
        manager
      rescue StandardError => e
        with_backtrace(logger, e)
        :error
      end
    end
  end
end
