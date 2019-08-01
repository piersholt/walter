# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Handler
      # Virtual::Handler::PacketHandler
      class PacketHandler < Core::BaseHandler
        include LogActually::ErrorOutput
        include Command::Parse

        PROG = 'Handler::Packet'
        LOG_BUILD_COMMAND = '#build_command'

        def initialize(bus, address_lookup_table = AddressLookupTable.instance)
          @bus = bus
          @address_lookup_table = address_lookup_table
        end

        def packet_received(properties)
          packet = packet?(properties)
          resolve_addresses(packet)
          return false unless addressable?(packet)
          message = parse_packet(packet)
          changed
          notify_observers(MESSAGE_RECEIVED, message: message)
        end

        private

        def resolve_addresses(packet)
          LOGGER.debug(PROG) { "#resolve_addresses(#{packet})" }

          from = @address_lookup_table.resolve_address(packet.from)
          packet.from = from
          LOGGER.debug(PROG) { "from_device: #{packet.sender}" }

          to = @address_lookup_table.resolve_address(packet.to)
          packet.to = to
          LOGGER.debug(PROG) { "to_device: #{packet.receiver}" }

          packet
        end

        def resolve_idents(message)
          LOGGER.debug(PROG) { "#resolve_addresses(#{message})" }

          from = @address_lookup_table.resolve_ident(message.from)
          message.sender = from
          LOGGER.debug(PROG) { "from_device: #{message.sender}" }

          to = @address_lookup_table.resolve_ident(message.to)
          message.receiver = to
          LOGGER.debug(PROG) { "to_device: #{message.receiver}" }

          message
        end

        ERROR_PACKET_NIL = 'Packet is nil!'

        def packet?(properties)
          packet = fetch(properties, :packet)
          raise(RoutingError, ERROR_PACKET_NIL) unless packet
          packet
        end

        def addressable?(packet)
          bus_has_sender?(packet.from)
          bus_has_recipient?(packet.to)
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

        def parse_packet(packet)
          bus_message = PacketWrapper.wrap(packet)

          from_ident = bus_message.from
          to_ident   = bus_message.to
          command    = bus_message.command
          args       = bus_message.arguments

          command_object = parse(from_ident, to_ident, command.i, args)

          Message.new(from_ident, to_ident, command_object)
        end
      end
    end
  end
end
