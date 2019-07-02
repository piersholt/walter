# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Environment
      # Application Context State Change
      module Environment
        include Logging

        def state_change(new_state)
          logger.debug(MANAGER) { "Environment => #{new_state.class}" }
          case new_state
          when Wilhelm::SDK::Environment::Online
            logger.info(MANAGER) { 'Enable Manager' }
            enable
          when Wilhelm::SDK::Environment::Offline
            logger.info(MANAGER) { 'Disable Mananger' }
            disable
          when Wilhelm::SDK::UserInterface::Context
            new_state
            .register_service_controllers(
              bluetooth: Wilhelm::Services::UserInterface::Controller::ManagerController
            )
          when Wilhelm::SDK::Notifications
            device_handler = Wilhelm::Services::Manager::Notifications::DeviceHandler.instance
            device_handler.manager = self
            new_state.register_handlers(device_handler)
          end
        end
      end
    end
  end
end
