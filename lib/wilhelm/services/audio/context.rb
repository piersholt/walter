# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Environment
      # Application context state change handling
      module Context
        include Logging

        attr_accessor :context

        def context_change(context)
          logger.debug(AUDIO) { "SDK::Context => #{context.class}" }
          case context
          when SDK::Context::ServicesContext::Online
            logger.info(AUDIO) { 'Context Online => Enable Audio.' }
            enable
          when SDK::Context::ServicesContext::Offline
            logger.info(AUDIO) { 'Context Offline => Disable Audio' }
            disable
          when SDK::Context::UserInterface
            logger.info(AUDIO) { 'Context UI => Register Audio Controllers' }
            context.register_service_controllers(
              audio: UserInterface::Controller::AudioController
            )
          when SDK::Context::Notifications
            logger.info(AUDIO) { 'Context Notifications => Register Notification Handlers' }
            target_handler =
              Notifications::TargetHandler.instance
            controller_handler =
              Notifications::ControllerHandler.instance
            target_handler.audio = self
            controller_handler.audio = self
            context.register_handlers(target_handler, controller_handler)
          end
        end
      end
    end
  end
end
