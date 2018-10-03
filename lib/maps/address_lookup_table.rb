require 'maps/map'
require 'devices/base_device'

require 'singleton'

class AddressLookupTable < Map
  include Singleton

  PROC = 'AddressLookupTable'
  SOURCE_PATH = 'address_lookup_table'.freeze

  def initialize
    super(SOURCE_PATH)
    # create_device_constants
  end

  def find(device_id)
    LOGGER.debug(PROC) { "#find(#{device_id})" }
    begin
      return mapped_result = super(device_id)
    rescue IndexError => e
      LOGGER.warn(PROC) {"Device #{DataTools.decimal_to_hex(device_id, true)} not found!" }
      return mapped_result = :universal
    end
  end
end
