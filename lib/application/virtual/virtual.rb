# frozen_string_literal: true

class Virtual
  class Devices
    extend Forwardable

    FORWARD_MESSAGES = Array.instance_methods(false)
    FORWARD_MESSAGES.each do |fwrd_message|
      def_delegator :@devices, fwrd_message
    end

    def initialize
      @devices = []
    end

    def include?(device_ident)
      @self.include?(device_ident)
    end

    def add(device)
      @devices << device
    end
  end

  class Device
    PROC = 'Device'.freeze

    def initialize(device_ident)
      @ident = device_ident
    end

    # @override Object#inspect
    def inspect
      "#<Device :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end
  end

  class Bus
    include Singleton
    attr_reader :devices

    def initialize
      @devices = Devices.new
    end

    def device?(device_ident)
      @devices.include?(device_ident)
    end

    def add_device(device)
      @devices.add(device)
    end
  end

  class Initialization
    PROC = 'Initialization'
    def initialize
      @executed = false
    end

    def execute
      bus = create_bus
      device_idents = lookup_devices
      devices = create_devices(device_idents)
      populate_bus(bus, devices)
      bus
    end

    def create_bus
      Bus.instance
    end

    def lookup_devices
      alt = AddressLookupTable.instance
      idents = alt.idents
      LOGGER.debug(PROC) { "Idents: #{idents}|" }
      idents
    end

    def create_devices(device_idents)
      devices = device_idents.map do |device_ident|
        Device.new(device_ident)
      end

      LOGGER.debug(PROC) { "Devices: #{devices}|" }
      devices
    end

    def populate_bus(bus, devices)
      devices.each do |device|
        bus.add_device(device)
      end

      LOGGER.debug(PROC) { "Bus Devices: #{bus.devices}" }
      true
    end
  end
end
