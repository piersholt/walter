# frozen_string_literal: false

# Comment
class DeviceMap < BaseMap
  DEVICES_MAP_NAME = 'devices'.freeze
  DEFAULT_NAMESPACE = 'Devices'
  DEFAULT_KLASS = 'BaseDevice'

  include Singleton
  include LogActually::ErrorOutput

  def name
    'DeviceMap'
  end

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

  PROC = 'DeviceMap'

  def address_lookup_table
    @address_lookup_table ||= AddressLookupTable.instance
  end

  def to_id(ident)
    address_lookup_table.get_address(ident)
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |line| LOGGER.error(line) }
  end

  def find_by_ident(device_ident)
    device_id = to_id(device_ident)
    find(device_id)
  end

  # Analyze: this was #find.. will cause bugs?
  def find(device_id)
    LOGGER.debug(PROC) { "#find(#{device_id})" }
    begin
      mapped_result = super(device_id)
    rescue IndexError => e
      # LOGGER.error(PROC) {"Device #{DataTools.decimal_to_hex(device_id, true)} not found!" }
      LOGGER.warn(PROC) {"Device #{device_id} not found!" }
      mapped_result = super(:universal)
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
      create_device_constant(id_d, device)
    end
  end

  def create_device_constant(id_d, device)
    LOGGER.debug(name) { "#create_device_constant(#{id_d}, device)" }
    device_sn = device[:properties][:short_name]
    device_ln = device[:properties][:long_name]
    return false if device_ln.eql?('Unknown')
    ns = Kernel.const_get(DEFAULT_NAMESPACE)
    # LOGGER.unknown("#{device_sn}")
    sanitized_device_sn = device_sn.gsub(/[^A-Z]/, '')
    # LOGGER.unknown("#{sanitized_device_sn}")
    ns.const_set(sanitized_device_sn, id_d)
    true
  rescue StandardError => e
    simple(LOGGER, e, name)
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
  rescue StandardError => e
    extra(LOGGER, "#{mapped_object[:id][:d]}", name)
    raise e
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
