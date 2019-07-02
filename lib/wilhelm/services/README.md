`wilhelm-services`

- listen to AppicationContext for state events.

* plugin configuration is programatic

Example:

    # Create Manager instance
    manager = Manager.new

    # Set initial state
    manager.disable

    # Register service with application context
    # note: environment is instance of Wilhelm::SDK::Environment
    environment.register_service(:manager, manager)

There are several application context hooks that a service leverages to configure itself:

    # lib/wilhelm/services/manager/service.rb

    # Note: full namespaces have been ommitted for brevity

    # called by application context on notify_observers
    def state_change(new_state)
      case new_state
      # Endpoint is UART
      when Online

      when Offline
        # Endpoint is Log
      when Wilhelm::SDK::UserInterface::Context
        # UI Context has been created
        new_state
        .register_service_controllers(
          bluetooth: UserInterface::Controller::ManagerController
        )
      when Wilhelm::SDK::Notifications
        device_handler = Manager::Notifications::DeviceHandler.instance
        device_handler.manager = self
        new_state.register_handlers(device_handler)
      end
    end
