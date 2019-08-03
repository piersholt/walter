# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Handler
      class DataHandler < Core::BaseHandler
        # Virtual::Handler::DataHandler
        module In
          include LogActually::ErrorOutput
          include Core::Constants::Events
          include Command::Parse

          PROG = 'Handler::Data::In'

          def data_received(properties)
            data = data?(properties)
            resolve_addresses(data)
            return false unless addressable?(data)
            message = parse_data(data)
            changed
            notify_observers(MESSAGE_RECEIVED, message: message)
          end

          private

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

          # RECEIVE: PARSE (Data -> Command)

          # @note Command::Parse
          def parse_data(data)
            data = DataAdapter.adapt(data)

            from_ident = data.from
            to_ident   = data.to
            command    = data.command
            args       = data.arguments

            command_object = parse(from_ident, to_ident, command, args)

            Message.new(from_ident, to_ident, command_object)
          end
        end
      end
    end
  end
end
