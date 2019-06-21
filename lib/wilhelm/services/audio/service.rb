# frozen_string_literal: true

module Wilhelm
  module Services
    # Comment
    class Audio
      include Observable
      include Logging
      include Properties
      include State
      include Notifications
      include Controls
      include Actions
      include Messaging::API

      attr_reader :state

      def initialize
        @state = Disabled.new
      end

      # Application Context State Change ----------------------------------------

      def state_change(new_state)
        logger.debug(AUDIO) { "Environment => #{new_state.class}" }
        case new_state
        when Wilhelm::SDK::Environment::Online
          logger.info(AUDIO) { 'Enable Audio' }
          enable
        when Wilhelm::SDK::Environment::Offline
          logger.info(AUDIO) { 'Disable Audio' }
          disable
        when Wilhelm::SDK::UserInterface::Context
          new_state
          .register_service_controllers(
            audio: Wilhelm::Services::UserInterface::Controller::AudioController
          )
        when Wilhelm::SDK::Notifications
          target_handler = Wilhelm::Services::Audio::Notifications::TargetHandler.instance
          controller_handler = Wilhelm::Services::Audio::Notifications::ControllerHandler.instance
          target_handler.audio = self
          controller_handler.audio = self
          new_state.register_handlers(target_handler, controller_handler)
        end
      end
    end
  end
end
