# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Parse
      module Parse
        PROG = 'Parse'

        def get_command_config(command_id, from_ident, to_ident)
          CommandMap.instance.config(
            command_id,
            from: from_ident,
            to: to_ident
          )
        end

        def parse(from_ident, to_ident, command, arguments)
          LOGGER.debug(PROG) { '#parse' }

          # 1. Byte Stream to Arguments Hash
          command_config = get_command_config(command, from_ident, to_ident)
          parameter_values_hash = parse_arguments(command_config, arguments)
          LOGGER.debug(PROG) { "Parameter Values: #{parameter_values_hash}" }

          # 2. Arguments Hash to Command
          build_command(command_config, parameter_values_hash)
        end

        private

        # 1. Byte Stream to Arguments Hash ------------------------------------

        def parse_arguments(command_config, arguments)
          if command_config.parameters? && !command_config.base?
            parse_indexed_arguments(command_config, arguments)
          else
            arguments
          end
        end

        def parse_indexed_arguments(command_config, arguments)
          parameter_values_hash = {}
          argument_index = command_config.index

          indexed_arguments = IndexedArguments.new(arguments, argument_index)
          indexed_arguments.parameters.each do |name|
            param_value = indexed_arguments.lookup(name)
            parameter_values_hash[name] = param_value
          end

          parameter_values_hash
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
        end

        # 2. Arguments Hash to Command ----------------------------------------

        LOG_BUILD_COMMAND = '#build_command'

        def build_command(command_config, parameter_values_hash)
          LOGGER.debug(PROG) { LOG_BUILD_COMMAND }
          command_builder = command_config.builder
          command_builder = command_builder.new(command_config)
          command_builder.add_parameters(parameter_values_hash)
          command_builder.result
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
        end
      end
    end
  end
end
