# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Map
      # Virtual::Map::AddressLookupTable
      class AddressLookupTable < Base
        include Singleton
        include Wilhelm::Helpers::DataTools

        PROC = 'AddressLookupTable'.freeze
        ADDDRESSES_MAP_NAME = 'address_lookup_table'.freeze

        def initialize(map = ADDDRESSES_MAP_NAME)
          super(map)
        end

        def resolve_address(device_id)
          LOGGER.debug(PROC) { "#resolve_address(#{device_id})" }
          find(device_id)
        rescue IndexError
          LOGGER.warn(PROC) { "Device: #{d2h(device_id, true)} not found!" }
          :universal
        end

        def resolve_ident(ident)
          LOGGER.debug(PROC) { "#resolve_ident(#{ident})" }
          found_id, _found_ident = map.find do |_, i|
            i == ident
          end
          raise(IndexError) unless found_id
          found_id
        rescue IndexError
          LOGGER.warn(PROC) { "Device: #{ident} not found!" }
          :universal
        end

        alias get_address resolve_ident
        alias get_ident   resolve_address

        def idents
          @map.values
        end

        def addresses
          @map.keys
        end

        alias ids addresses
      end
    end
  end
end
