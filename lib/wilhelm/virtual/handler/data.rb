# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Handler
      # Virtual::Handler::DataHandler
      class DataHandler < Core::BaseHandler
        include LogActually::ErrorOutput
        include Command::Parse

        PROG = 'Handler::Data'
        ERROR_DATA_NIL = 'Data is nil!'

        def initialize(bus, data_output_buffer, address_lookup_table = AddressLookupTable.instance)
          @bus = bus
          @data_output_buffer = data_output_buffer
          @address_lookup_table = address_lookup_table
        end

        def data_received(properties)
          data = data?(properties)
          resolve_addresses(data)
          return false unless addressable?(data)
          message = parse_data(data)
          changed
          notify_observers(MESSAGE_RECEIVED, message: message)
        end

        def data_sent(properties)
          message = data?(properties)
          data = generate_data(message)
          add_to_output_buffer(data)
        end

        private

        # RECEIVE -------------------------------------------------------------

        def resolve_addresses(data)
          LOGGER.debug(PROG) { "#resolve_addresses(#{data})" }

          from = @address_lookup_table.resolve_address(data.from)
          data.from = from
          LOGGER.debug(PROG) { "from_device: #{data.sender}" }

          to = @address_lookup_table.resolve_address(data.to)
          data.to = to
          LOGGER.debug(PROG) { "to_device: #{data.receiver}" }

          data
        end

        # @deprecated I think?
        def resolve_idents(message)
          LOGGER.debug(PROG) { "#resolve_idents(#{message})" }

          from = @address_lookup_table.resolve_ident(message.from)
          message.sender = from
          LOGGER.debug(PROG) { "from_device: #{message.sender}" }

          to = @address_lookup_table.resolve_ident(message.to)
          message.receiver = to
          LOGGER.debug(PROG) { "to_device: #{message.receiver}" }

          message
        end

        def data?(properties)
          data = fetch(properties, :data)
          raise(RoutingError, ERROR_DATA_NIL) unless data
          data
        end

        def addressable?(data)
          bus_has_sender?(data.from)
          bus_has_recipient?(data.to)
          true
        rescue RoutingError
          true
        end

        def bus_has_sender?(from_ident)
          has_from = bus_has_device?(from_ident)
          raise(RoutingError, "#{from_ident} is not on bus!") unless has_from
        end

        def bus_has_recipient?(to_ident)
          has_to = bus_has_device?(to_ident)
          raise(RoutingError, "#{to_ident} is not on bus!") unless has_to
        end

        def bus_has_device?(device_ident)
          @bus.device?(device_ident)
        end

        # SEND ----------------------------------------------------------------

        # PARSE ---------------------------------------------------------------

        def parse_data(data)
          data = DataAdapter.adapt(data)

          from_ident = data.from
          to_ident   = data.to
          command    = data.command
          args       = data.arguments

          command_object = parse(from_ident, to_ident, command.i, args)

          Message.new(from_ident, to_ident, command_object)
        end

        # GENERATE ------------------------------------------------------------

        def generate_data(message)
          from    = message.from
          to      = message.to
          payload = message_data(message)

          Data.new(from, to, payload)
        end

        def message_data(message)
          # HACK: BaseCommand::Raw has no sender/receiver in scope!
          message.command.load_command_config(message.from, message.to)
          message.command.generate
        end

        def add_to_output_buffer(data)
          result = @data_output_buffer.push(data)
          LOGGER.debug(PROG) { "#add_to_output_buffer(#{data}) => #{result}" }
          result
        end
      end
    end
  end
end
