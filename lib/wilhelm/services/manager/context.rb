# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Environment
      # Application Context State Change
      module Context
        include Logging

        def state_change(new_state)
          logger.debug(MANAGER) { "Environment => #{new_state.class}" }
          case new_state
          when Wilhelm::SDK::Context::ServicesContext::Online
            logger.info(MANAGER) { 'Enable Manager' }
            enable
          when Wilhelm::SDK::Context::ServicesContext::Offline
            logger.info(MANAGER) { 'Disable Mananger' }
            disable
          when Wilhelm::SDK::UserInterface::Context
            new_state
            .register_service_controllers(
              bluetooth: UserInterface::Controller::ManagerController
            )
          when Wilhelm::SDK::Context::Notifications
            device_handler = Notifications::DeviceHandler.instance
            device_handler.manager = self
            new_state.register_handlers(device_handler)
          end
        end
      end
    end
  end
end
