# frozen_string_literal: true

class Walter
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
      logger.debug(AUDIO) { "ApplicationContext => #{new_state.class}" }
      case new_state
      when Wilhelm::ApplicationContext::Online
        logger.info(AUDIO) { 'Enable Audio' }
        enable
      when Wilhelm::ApplicationContext::Offline
        logger.info(AUDIO) { 'Disable Audio' }
        disable
      when Wilhelm::UserInterface::Context
        new_state
          .register_service_controllers(
            audio: Walter::UserInterface::Controller::AudioController
          )
      when Wilhelm::Notifications
        target_handler = Walter::Audio::Notifications::TargetHandler.instance
        controller_handler = Walter::Audio::Notifications::ControllerHandler.instance
        target_handler.audio = self
        controller_handler.audio = self
        new_state.register_handlers(target_handler, controller_handler)
      end
    end
  end
end
