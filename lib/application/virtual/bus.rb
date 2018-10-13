class Virtual
  class Bus
    include Singleton
    extend Forwardable

    attr_reader :devices

    def_delegators :@devices, :send_all, :simulated, :broadcast, :dumb

    def initialize
      @devices = Devices.new
      @status = :down
    end

    def online
      @status = :up
    end

    def offline
      @status = :down
    end

    def device?(device_ident)
      @devices.include?(device_ident)
    end

    def add_device(device)
      @devices.add(device)
    end
  end
end
