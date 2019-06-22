# frozen_string_literal: true

# Top level namespace
module Wilhelm
  module SDK
    class Environment
      # Wilhelm Service Online State
      class Online
        include Defaults
        include Constants

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

          # logger.debug(WILHELM_ONLINE) { 'Disconnect Client.' }
          # Client.disconnect
          # logger.debug(WILHELM_ONLINE) { 'Disconnect Publisher.' }
          # Publisher.disconnect
          # logger.debug(WILHELM_ONLINE) { 'Destroy context.' }
          # Publisher.destroy
          # context.offline!
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

        def load_nodes(context)
          context.ui.launch(:nodes, :index)
        end

        def load_services(context)
          context.ui.launch(:services, :index)
        end

        # Services

        def load_bluetooth(context, *)
          context.ui.launch(:bluetooth, :index)
        end

        def load_audio(context)
          context.ui.launch(:audio, :index)
        end

        def load_now_playing(context)
          context.ui.launch(:audio, :now_playing)
        end

        private

        # APPLICATION CONTEXT ---------------------------------------------------

        def create_notifications(context)
          logger.debug(WILHELM_ONLINE) { '#create_notifications' }
          notifications = Notifications.new(context)
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
          LOGGER.debug(WILHELM) { "#create_ui (#{Thread.current})" }
          ui_context = Wilhelm::SDK::UserInterface::Context.new(context)
          register_service_controllers(ui_context)
          context.changed
          context.notify_observers(ui_context)
          ui_context
        rescue StandardError => e
          with_backtrace(logger, e)
        end

        def register_service_controllers(ui_context)
          LOGGER.debug(WILHELM) do
            "#register_service_controllers (#{Thread.current})"
          end
          ui_context.register_service_controllers(
            header:  Wilhelm::SDK::UserInterface::Controller::HeaderController,
            debug:  Wilhelm::SDK::UserInterface::Controller::DebugController,
            nodes:  Wilhelm::SDK::UserInterface::Controller::NodesController,
            services:  Wilhelm::SDK::UserInterface::Controller::ServicesController,
            characters:  Wilhelm::SDK::UserInterface::Controller::CharactersController
          )
        rescue StandardError => e
          with_backtrace(logger, e)
        end
      end
    end
  end
end