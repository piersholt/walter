module Wolfgang
  class Manager
    include Logging
    include Messaging::API
    include Observable

    attr_reader :state

    def initialize
      @state = Disabled.new
    end

    # Application Context State Change ----------------------------------------

    def state_change(new_state)
      logger.unknown(MANAGER) { "ApplicationContext => #{new_state.class}" }
      case new_state
      when Wolfgang::ApplicationContext::Online
        logger.debug(MANAGER) { 'Enable Manager' }
        enable
      when Wolfgang::ApplicationContext::Offline
        logger.debug(MANAGER) { 'Disable Mananger' }
        disable
      when Wolfgang::UserInterface::Context
        new_state.register_service_controllers(
          bluetooth: Wolfgang::UserInterface::Controller::BluetoothController
        )
      end
    end

    # States ------------------------------------------------------------

    def change_state(new_state)
      logger.info(MANAGER) { "state change => #{new_state.class}" }
      @state = new_state
      changed
      notify_observers(@state)
      @state
    end

    def enable
      @state.enable(self)
    end

    def disable
      @state.disable(self)
    end

    def on
      @state.on(self)
    end

    # Properties ------------------------------------------------------------

    def devices
      @devices ||= Devices.new
    end

    # Commands ------------------------------------------------------------

    def connect_device(device_address)
      @state.connect_device(self, device_address)
    end

    def disconnect_device(device_address)
      @state.disconnect_device(self, device_address)
    end

    # Notifications ------------------------------------------------------------

    def device_connecting(properties)
      @state.device_connecting(self, properties)
    end

    def device_connected(properties)
      @state.device_connected(self, properties)
    end

    def device_disconnecting(properties)
      @state.device_disconnecting(self, properties)
    end

    def device_disconnected(properties)
      @state.device_disconnected(self, properties)
    end

    def new_device(properties)
      @state.new_device(self, properties)
    end

    # API

    def devices?
      devices!(devices_callback(self))
    end

    def devices_callback(context)
      proc do |reply, error|
        begin
          if reply
            logger.info(MANAGER) { "#devices_callback(#{reply})" }
            # logger.info(MANAGER) { "reply => #{reply}" }
            context.devices.update_devices(reply.properties)
            context.on
          else
            logger.warn(MANAGER) { "Error! (#{error})" }
            # context.offline!
          end
        rescue StandardError => e
          logger.error(MANAGER) { e }
          e.backtrace.each { |line| logger.error(MANAGER) { line } }
          context.change_state(Disabled.new)
        end
      end
    end
  end
end
