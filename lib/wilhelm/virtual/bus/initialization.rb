# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Bus
      # Virtual::Bus::Initialization
      class Initialization
        PROC = 'Initialization'.freeze

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
          idents = Map::AddressLookupTable.instance.idents
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
            Device::Dynamic.builder.target(device_ident).type(:emulated).result
          elsif @augmented.include?(device_ident)
            LOGGER.debug(PROC) { "Create Augmented #{device_ident}" }
            Device::Dynamic.builder.target(device_ident).type(:augmented).result
          else
            LOGGER.debug(PROC) { "Create dumb: #{device_ident}|" }
            Device::Base.new(device_ident)
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
