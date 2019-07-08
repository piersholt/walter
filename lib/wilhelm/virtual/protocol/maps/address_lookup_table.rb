# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Comment
    class AddressLookupTable < BaseMap
      include Singleton
      include Wilhelm::Helpers::DataTools

      PROC = 'AddressLookupTable'
      SOURCE_PATH = 'address_lookup_table'.freeze

      def initialize
        super(SOURCE_PATH)
        # create_device_constants
      end

      def find(device_id)
        LOGGER.debug(PROC) { "#find(#{device_id})" }
        mapped_result = super(device_id)
      rescue IndexError => e
        LOGGER.warn(PROC) {"Device #{decimal_to_hex(device_id, true)} not found!" }
        mapped_result = :universal
      end

      alias resolve_address find

      def down(ident)
        # LOGGER.debug(PROC) { "#down(#{ident})" }
        mapped_result = nil
        map.each { |k, v|  mapped_result = k if v == ident }
        raise IndexError unless mapped_result
        mapped_result
      rescue IndexError => e
        LOGGER.warn(PROC) {"#{ident} not found!" }
        mapped_result = :universal
        mapped_result
      end

      alias resolve_ident down

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
  end
end
