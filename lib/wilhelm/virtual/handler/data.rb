# frozen_string_literal: true

require_relative 'data/in'
require_relative 'data/out'

module Wilhelm
  module Virtual
    module Handler
      # Virtual::Handler::DataHandler
      class DataHandler < Core::BaseHandler
        include LogActually::ErrorOutput
        include In
        include Out

        PROG = 'Handler::Data'
        ERROR_DATA_NIL = 'Data is nil!'

        def initialize(bus, data_output_buffer, address_lookup_table = AddressLookupTable.instance)
          @bus = bus
          @data_output_buffer = data_output_buffer
          @address_lookup_table = address_lookup_table
        end

        def data?(properties)
          data = fetch(properties, :data)
          raise(RoutingError, ERROR_DATA_NIL) unless data
          data
        end
      end
    end
  end
end
