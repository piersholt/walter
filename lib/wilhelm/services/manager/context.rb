# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Environment
      # Application Context State Change
      module Context
        include Logging

        attr_accessor :context

        def context_change(context)
          logger.debug(MANAGER) { "SDK::Context => #{context.class}" }
          case context
          when SDK::Context::ServicesContext::Online
            logger.info(MANAGER) { 'Context Online => Enable Manager.' }
            enable
          when SDK::Context::ServicesContext::Offline
            logger.info(MANAGER) { 'Context Offline => Disable Manager' }
            disable
          when SDK::Context::UserInterface
            logger.info(MANAGER) { 'Context UI => Register Controllers' }
            context.register_service_controllers(
              manager: UserInterface::Controller::ManagerController
            )
          when SDK::Context::Notifications
            logger.info(MANAGER) { 'Context Notifications => Register Notification Handlers' }
            device_handler = Notifications::DeviceHandler.instance
            device_handler.manager = self
            context.register_handlers(device_handler)
          end
        end
      end
    end
  end
end
