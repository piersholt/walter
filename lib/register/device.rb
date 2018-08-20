require 'register'

class Device
  extend Register
  include Register

  attr_accessor :id, :address, :short_name, :long_name, :created_at, :updated_at
  # alias :id :address

  def initialize(device_id, short_name = DataTools.decimal_to_hex(device_id, true), long_name = 'Unknown')
    setup_register(:device)
    @id = device_id
    @address = { h: DataTools.decimal_to_hex(device_id), d: device_id }

    @short_name = short_name
    @long_name = long_name

    @created_at = DateTime.now
    @updated_at = DateTime.now
  end

  def self.lookup_device(key)
    LOGGER.debug("Device / Lookup: #{key}")
    result = lookup(:device, key)
    LOGGER.debug("Device / Lookup: #{key} / Result: #{result}")
    result.updated_at = DateTime.now unless result.nil?
    result
  end

  def d
    @address[:d]
  end

  def h
    DataTools.decimal_to_hex(d)
  end

  def self.close
    close_register(:device)
  end

  # def self.update(message)
  #   close if message.nil? && return
  #   create(:device, message.from.id, message.from)
  #   create(:device, message.to.id, message.to)
  # end

  def self.update(device_id, device)
    close if device_id.nil? && return
    create(:device, device_id, device)
    # create(:device, message.to.id, message.to)
  end

  def to_s
    "#{@address}: #{@short_name} / #{@long_name}"
  end
end
