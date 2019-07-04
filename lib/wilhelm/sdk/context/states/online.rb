# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Wilhelm Service Online State
        class Online
          include Defaults
          include Logging

          def online!(___)
            logger.debug(WILHELM_ONLINE) { '#online' }
            logger.warn(WILHELM_ONLINE) { 'State is already Online!' }
          end

          def offline!(context)
            logger.debug(WILHELM_ONLINE) { '#offline' }
            context.change_state(Offline.new)
            # Application Context
            logger.debug(WILHELM_ONLINE) { 'Stop Notifications' }
            context.notifications&.stop
          end

          # APPLICATION CONTEXT -----------------------------------------------------

          def notifications!(context)
            logger.debug(WILHELM_ONLINE) { '#notifications' }
            context.notifications = create_notifications(context)
            true
          end

          def ui!(context)
            logger.debug(WILHELM_ONLINE) { '#ui' }
            context.ui = create_ui(context)
            true
          end

          # UI --------------------------------------------------------------

          # Application Context

          def load_debug(context)
            context.ui.launch(:debug, :index)
          end

          def load_services(context)
            context.ui.launch(:services, :index)
          end

          private

          # APPLICATION CONTEXT ---------------------------------------------------

          def create_notifications(context)
            logger.debug(WILHELM_ONLINE) { '#create_notifications' }
            notifications = Context::Notifications.new(context)
            context.changed
            context.notify_observers(notifications)
            # logger.debug(WILHELM_ONLINE) { '#notifications.start =>' }
            notifications.start
            # logger.debug(WILHELM_ONLINE) { '#notifications' }
            notifications
          rescue StandardError => e
            with_backtrace(logger, e)
          end

          def create_ui(context)
            LOGGER.debug(WILHELM_ONLINE) { "#create_ui (#{Thread.current})" }
            ui_context = UserInterface.new(context)
            register_service_controllers(ui_context)
            context.changed
            context.notify_observers(ui_context)
            ui_context
          rescue StandardError => e
            with_backtrace(logger, e)
          end

          def register_service_controllers(ui_context)
            LOGGER.debug(WILHELM_ONLINE) do
              "#register_service_controllers (#{Thread.current})"
            end
            ui_context.register_service_controllers(
              header:  UserInterface::Controller::HeaderController,
              debug:  UserInterface::Controller::DebugController,
              services:  UserInterface::Controller::ServicesController,
              characters:  UserInterface::Controller::CharactersController
            )
          rescue StandardError => e
            with_backtrace(logger, e)
          end
        end
      end
    end
  end
end
