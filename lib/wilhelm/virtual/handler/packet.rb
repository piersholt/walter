# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Handler
      # Comment
      class PacketHandler < Core::BaseHandler
        include LogActually::ErrorOutput

        def initialize(bus)
          @bus = bus
        end

        def packet_received(properties)
          packet = packet?(properties)
          return false unless addressable?(packet)
          message = parse_packet(packet)
          changed
          # LOGGER.warn(self.class) { "notify_observers(MESSAGE_RECEIVED, message: message)" }
          notify_observers(MESSAGE_RECEIVED, message: message)
        end

        private

        def packet?(properties)
          packet = fetch(properties, :packet)
          raise RoutingError, 'Packet is nil!' unless packet
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
          raise RoutingError, "#{from_ident} is not on the bus." unless has_from
        end

        def bus_has_recipient?(to_ident)
          has_to = bus_has_device?(to_ident)
          raise RoutingError, "#{to_ident} is not on the bus." unless has_to
        end

        def bus_has_device?(device_ident)
          @bus.device?(device_ident)
        end

        def parse_packet(packet)
          bus_message = Wilhelm::Virtual::PacketWrapper.wrap(packet)

          from_ident = bus_message.from
          to_ident   = bus_message.to
          command    = bus_message.command
          args       = bus_message.arguments

          command_object = parse_command(from_ident, command.i, args)

          Wilhelm::Virtual::Message.new(from_ident, to_ident, command_object)
        end

        def parse_command(from_ident, command, arguments)
          command_config = Wilhelm::Core::CommandMap.instance.config(command, from_ident)
          parameter_values_hash = parse_argumets(command_config, arguments)
          LOGGER.debug(self.class) { "Parameter Values: #{parameter_values_hash}" }
          command_object = build_command(command_config, parameter_values_hash)
          # LOGGER.info(ident) { command_object }
          command_object
        end

        private

        def parse_argumets(command_config, arguments)
          # LOGGER.info(ident) { "#parse_argumets" }
          if command_config.has_parameters? && !command_config.is_base?
            # LOGGER.info(ident) { "#{command_config.sn} has a klass and parameters. Will parse." }
            parse_indexed_arguments(command_config, arguments)
          else
            # LOGGER.info(ident) { "#{command_config.sn} is getting plain old arguments." }
            arguments
          end
        end

        def parse_indexed_arguments(command_config, arguments)
          parameter_values_hash = {}
          begin
            argument_index = command_config.index
            LOGGER.debug(self.class) { "argument index: #{argument_index}" }
            indexed_arguments = Wilhelm::Core::IndexedArguments.new(arguments, argument_index)
            LOGGER.debug(self.class) { "indexed_arguments: #{indexed_arguments}" }

            indexed_arguments.parameters.each do |name|
              param_value = indexed_arguments.lookup(name)
              LOGGER.debug(self.class) { "indexed_arguments.lookup(#{name}) => #{param_value ? param_value : 'NULL'}" }
              parameter_values_hash[name] = param_value
            end

            parameter_values_hash
          rescue StandardError => e
            LOGGER.error(self.class) { "#{e}" }
            e.backtrace.each { |l| LOGGER.error(l) }
            binding.pry
          end
        end

        def build_command(command_config, parameter_values_hash)
          LOGGER.debug(self.class) { "#build_command" }
          begin
            command_builder = command_config.builder
            command_builder = command_builder.new(command_config)
            command_builder.add_parameters(parameter_values_hash)

            command_builder.result
          rescue StandardError => e
            LOGGER.error(self.class) { "#{e}" }
            e.backtrace.each { |l| LOGGER.error(l) }
            binding.pry
          end
        end
      end
    end
  end
end
