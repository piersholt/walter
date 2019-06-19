# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Bus
      # Comment
      class Initialization
        PROC = 'Initialization'
        def initialize(emulated: [], augmented: [])
          @emulated = emulated
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
          idents = Core::AddressLookupTable.instance.idents
          LOGGER.debug(PROC) { "Idents: #{idents}|" }
          idents
        end

        def create_devices(device_idents)
          device_idents.map do |device_ident|
            create_device(device_ident)
          end
        end

        def create_device(device_ident)
          if @emulated.include?(device_ident)
            LOGGER.debug(PROC) { "Create Emulated #{device_ident}" }
            DynamicDevice.builder
            .target(device_ident)
            .result
          elsif @augmented.include?(device_ident)
            LOGGER.debug(PROC) { "Create Augmented #{device_ident}" }
            augmented_device =
            DynamicDevice.builder
            .target(device_ident)
            .result
            # augmented_device.add_observer(intent_listener, :handle)
            augmented_device
          else
            LOGGER.debug(PROC) { "Create dumb: #{device_ident}|" }
            Device.new(device_ident)
          end
        end

        # def intent_listener
        #   @intent_listener ||= IntentListener.instance
        # end

        def populate_bus(bus, devices)
          devices.each do |device|
            bus.add_device(device)
          end

          LOGGER.debug(PROC) { "Bus Devices: #{bus.devices}" }
          true
        end
      end
    end
  end
end
