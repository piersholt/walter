class Virtual
  module Receivable
    include Event
    def receive_packet(packet)
      bus_message = PacketWrapper.wrap(packet)

      from_ident = bus_message.from
      to_ident   = bus_message.to
      command    = bus_message.command
      args       = bus_message.arguments

      command_object = parse_command(from_ident, command.i, args)

      message = Message.new(from_ident, to_ident, command_object)

      notify(message)

      message
    end

    def junk_mail?(message)
      ident == message.to ? false : true
    end

    def notify(message)
      if junk_mail?(message)
        # LOGGER.warn(ident) { 'FOUND A JUNKER!' }
        return false
      end
      changed
      notify_observers(MESSAGE_RECEIVED, message: message)
    end

    def parse_command(from_ident, command, arguments)
      command_config = CommandMap.instance.config(command, from_ident)
      parameter_values_hash = parse_argumets(command_config, arguments)
      LOGGER.debug(ident) { "Parameter Values: #{parameter_values_hash}" }
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
        LOGGER.debug(ident) { "argument index: #{argument_index}" }
        indexed_arguments = IndexedArguments.new(arguments, argument_index)
        LOGGER.debug(ident) { "indexed_arguments: #{indexed_arguments}" }

        indexed_arguments.parameters.each do |name|
          param_value = indexed_arguments.lookup(name)
          LOGGER.debug(ident) { "indexed_arguments.lookup(#{name}) => #{param_value ? param_value : 'NULL'}" }
          parameter_values_hash[name] = param_value
        end

        parameter_values_hash
      rescue StandardError => e
        LOGGER.error(ident) { "#{e}" }
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end

    def build_command(command_config, parameter_values_hash)
      LOGGER.debug(ident) { "#build_command" }
      begin
        command_builder = command_config.builder
        command_builder = command_builder.new(command_config)
        command_builder.add_parameters(parameter_values_hash)

        command_builder.result
      rescue StandardError => e
        LOGGER.error(ident) { "#{e}" }
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end
  end
end
