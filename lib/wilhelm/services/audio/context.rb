# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Environment
      # Application context state change handling
      module Context
        include Logging

        def state_change(new_state)
          logger.debug(AUDIO) { "Environment => #{new_state.class}" }
          case new_state
          when Wilhelm::SDK::Context::ServicesContext::Online
            logger.info(AUDIO) { 'Enable Audio' }
            enable
          when Wilhelm::SDK::Context::ServicesContext::Offline
            logger.info(AUDIO) { 'Disable Audio' }
            disable
          when Wilhelm::SDK::UserInterface::Context
            new_state
              .register_service_controllers(
                audio:
                  Wilhelm::Services::UserInterface::Controller::AudioController
              )
          when Wilhelm::SDK::Context::Notifications
            target_handler =
              Notifications::TargetHandler.instance
            controller_handler =
              Notifications::ControllerHandler.instance
            target_handler.audio = self
            controller_handler.audio = self
            new_state.register_handlers(target_handler, controller_handler)
          end
        end
      end
    end
  end
end
