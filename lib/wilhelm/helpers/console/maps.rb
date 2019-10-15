# frozen_string_literal: false

module Wilhelm
  module Helpers
    module Console
      # Console::Maps
      module Maps
        def command_map
          Wilhelm::Virtual::Map::Command.instance
        end

        alias cm command_map

        def address_lookup_table
          Wilhelm::Virtual::Map::AddressLookupTable.instance
        end

        alias alt address_lookup_table
      end
    end
  end
end
