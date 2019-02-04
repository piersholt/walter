module Wolfgang
  class Manager
    include Logger
    include Messaging::API

    attr_reader :state

    def initialize
      @state = Disabled.new
    end

    # States ------------------------------------------------------------

    def change_state(new_state)
      logger.info(MANAGER) { "state change => #{new_state.class}" }
      @state = new_state
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
  end
end
