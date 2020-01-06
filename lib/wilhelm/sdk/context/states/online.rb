# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Wilhelm Service Online State
        class Online
          include Defaults
          include Logging

          def initialize(context)
            logger.debug(WILHELM_ONLINE) { '#initialize' }
            notifications!(context)
            ui!(context)
            context.register_controls(Wilhelm::API::Controls.instance)
          end

          def offline!(context)
            logger.debug(WILHELM_ONLINE) { '#offline' }
            context.change_state(Offline.new(context))
          end

          # APPLICATION CONTEXT -----------------------------------------------

          def notifications!(context)
            logger.debug(WILHELM_ONLINE) { '#notifications! (creating...)' }
            context.notifications = create_notifications(context)
            true
          end

          def ui!(context)
            logger.debug(WILHELM_ONLINE) { '#ui! (creating...)' }
            context.ui = create_ui(context)
            true
          end

          # UI --------------------------------------------------------------

          # Application Context

          def load_context(context)
            context.ui.launch(:context, :index)
          end

          private

          # APPLICATION CONTEXT -----------------------------------------------

          def create_notifications(context)
            logger.debug(WILHELM_ONLINE) { '#create_notifications' }
            notifications = Context::Notifications.new(context)

            context.changed
            context.notify_observers(notifications)

            notifications.start
            notifications
          rescue StandardError => e
            with_backtrace(logger, e)
          end

          def create_ui(context)
            logger.debug(WILHELM_ONLINE) { "#create_ui (#{Thread.current})" }
            ui_context = UserInterface.new(context)
            register_context_controllers(ui_context)
            context.changed
            context.notify_observers(ui_context)
            ui_context
          rescue StandardError => e
            with_backtrace(logger, e)
          end

          def register_context_controllers(ui_context)
            logger.debug(WILHELM_ONLINE) do
              "#register_context_controllers (#{Thread.current})"
            end
            ui_context.register_service_controllers(
              header:  UserInterface::Controller::HeaderController,
              context:  UserInterface::Controller::ContextController,
              services:  UserInterface::Controller::ServicesController,
              encoding:  UserInterface::Controller::EncodingController
            )
          end
        end
      end
    end
  end
end
