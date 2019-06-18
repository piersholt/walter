# frozen_string_literal: true

module Wilhelm
  # Comment
  class Manager
    include Observable
    include Logging
    include State
    include Notifications
    include Actions
    include Requests
    include Messaging::API

    attr_reader :state

    def initialize
      @state = Disabled.new
    end

    # Application Context State Change ----------------------------------------

    def state_change(new_state)
      logger.debug(MANAGER) { "ApplicationContext => #{new_state.class}" }
      case new_state
      when Wilhelm::SDK::ApplicationContext::Online
        logger.info(MANAGER) { 'Enable Manager' }
        enable
      when Wilhelm::SDK::ApplicationContext::Offline
        logger.info(MANAGER) { 'Disable Mananger' }
        disable
      when Wilhelm::SDK::UserInterface::Context
        new_state
          .register_service_controllers(
            bluetooth: Wilhelm::UserInterface::Controller::BluetoothController
          )
      when Wilhelm::SDK::Notifications
        device_handler = Wilhelm::Manager::Notifications::DeviceHandler.instance
        device_handler.manager = self
        new_state.register_handlers(device_handler)
      end
    end

    # Properties ------------------------------------------------------------

    def devices
      @devices ||= Devices.new
    end
  end
end
