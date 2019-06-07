# frozen_string_literal: true

module Wolfgang
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
      logger.unknown(AUDIO) { "ApplicationContext => #{new_state.class}" }
      case new_state
      when Wolfgang::ApplicationContext::Online
        logger.debug(AUDIO) { 'Enable Audio' }
        enable
      when Wolfgang::ApplicationContext::Offline
        logger.debug(AUDIO) { 'Disable Audio' }
        disable
      when Wolfgang::UserInterface::Context
        new_state.register_service_controllers(
          audio: Wolfgang::UserInterface::Controller::AudioController
        )
      end
    end
  end
end
