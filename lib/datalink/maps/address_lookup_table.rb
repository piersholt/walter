require 'maps/map'
require 'application/devices/base_device'

require 'singleton'

class AddressLookupTable < BaseMap
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
      mapped_result = super(device_id)
    rescue IndexError => e
      LOGGER.warn(PROC) {"Device #{DataTools.decimal_to_hex(device_id, true)} not found!" }
      mapped_result = :universal
    end
  end

  def down(ident)
    # LOGGER.debug(PROC) { "#down(#{ident})" }
    begin
      mapped_result = nil
      map.each { |k, v|  mapped_result = k if v == ident }
      raise IndexError unless mapped_result
      mapped_result
    rescue IndexError => e
      LOGGER.warn(PROC) {"#{ident} not found!" }
      mapped_result = :universal
      mapped_result
    end
  end

  def get_ident(device_id)
    find(device_id)
  end

  def get_address(ident)
    # LOGGER.debug(PROC) { "#get_address(#{ident})" }
    address = down(ident)
    # LOGGER.debug(PROC) { "#get_address(#{ident}) => address" }
    address
  end

  def idents
    @map.values
  end

  def ids
    @map.keys
  end
end
