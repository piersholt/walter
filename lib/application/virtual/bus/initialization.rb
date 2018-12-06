require 'application/intents/intents'

class Virtual
  class Initialization
    PROC = 'Initialization'
    def initialize(simulated: [], augmented: [])
      @simulated = simulated
      @augmented = augmented
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
        create_device(device_ident)
      end

      LOGGER.debug(PROC) { "Devices: #{devices}|" }
      devices
    end

    def create_device(device_ident)
      if @simulated.include?(device_ident)
        DynamicDevice.builder
                     .target(device_ident)
                     .result
      elsif @augmented.include?(device_ident)
        augmented_device =
          DynamicDevice.builder
                       .target(device_ident)
                       .result
        augmented_device.add_observer(intent_listener, :handle)
        augmented_device
      else
        Device.new(device_ident)
      end
    end

    def intent_listener
      @intent_listener ||= IntentListener.instance
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
