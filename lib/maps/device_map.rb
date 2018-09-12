require 'maps/map'
require 'devices/base_device'

require 'singleton'

class DeviceMap < Map
  DEVICES_MAP_NAME = 'devices'.freeze
  DEFAULT_NAMESPACE = 'Devices'
  DEFAULT_KLASS = 'BaseDevice'

  include Singleton

  def initialize
    super(DEVICES_MAP_NAME)
    create_device_constants
  end
  # lookup the device by decimal ID
  # instantiate a device of type mapped_object.klass
  # def find()
  #   result.add_observers(self, :update_map)
  # end

  # whenHash a device that's instanced from the map
  # has udpate called it notifies the parent map.
  # i want the map to be very dynamic
  # over time i can update the mapped objet klass
  # types and the new types are hidden from the update
  # implementation
  # def update_map(args)
  #
  # end

  def find(device_id)
    LOGGER.debug("DeviceMap") { "#{self.class}#find(#{device_id})" }
    begin
      mapped_result = super(device_id)
    rescue IndexError => e
      LOGGER.error('DeviceMap') {"Device #{DataTools.decimal_to_hex(device_id, true)} not found!" }
      mapped_result = super(:default)
      mapped_result[:properties][:d] = device_id
    end
    instantiate_klass(mapped_result)
  end

  # onot part of map as it's specific to the contents of the map
  def find_by(args)
    # binding.pry
    LOGGER.debug("#{self.class}#find_by(#{args})")
    # puts args
    id = args[:id]
    # super.public_send(:find, id)
  end

  private

  def create_device_constants
    map.each do |id_d, device|
      device_sn = device[:properties][:short_name]
      device_ln = device[:properties][:long_name]
      next if device_ln.eql?('Unknown')
      ns = Kernel.const_get(DEFAULT_NAMESPACE)
      # LOGGER.unknown("#{device_sn}")
      sanitized_device_sn = device_sn.gsub(/[^A-Z]/, '')
      # LOGGER.unknown("#{sanitized_device_sn}")
      ns.const_set(sanitized_device_sn, id_d)
    end
  end

  def instantiate_klass(mapped_object)
    klass_ns = DEFAULT_NAMESPACE
    object_klass = mapped_object[:klass]
    klass = klass_const(klass_ns, object_klass)

    id = mapped_object[:id]
    properties = mapped_object[:properties]
    Kernel.const_defined?(klass)
    klass = Kernel.const_get(klass)
    klass.new(id, properties)
  end

  def klass_const(klass_ns, klass)
    "#{klass_ns}::#{klass}"
  end
end

# class Device
#   def update
#     change(true)
#     notify_observers(self)
#   end
# end
