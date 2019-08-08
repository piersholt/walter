# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Generate
      module Generate
        PROG = 'Generate'
        ERROR_CONFIG_NIL = 'command_config is nil!'

        def command_config
          raise(StandardError, ERROR_CONFIG_NIL) unless @command_config
          @command_config
        end

        def command_map
          Map::Command.instance
        end

        def get_command_config(command_id, from_ident, to_ident)
          command_map.config(command_id, from: from_ident, to: to_ident)
        end

        # HACK: yeah this is fucking awful. See Multiplexer and API::Base.
        # Called by Multiplexer as Command has no reference to from/to
        def load_command_config(from, to)
          from_ident = resolve_address(from)
          to_ident = resolve_address(to)
          @command_config = get_command_config(id, from_ident, to_ident)
          raise(StandardError, ERROR_CONFIG_NIL) unless command_config
          true
        end

        def resolve_address(device_id)
          Map::AddressLookupTable.instance.resolve_address(device_id)
        end

        def generate
          LOGGER.debug(PROG) { '#generate' }
          # loaded by Multiplexer, so just call to trigger any errors
          command_config

          generate_arguments(command_config)
        end

        private

        def generate_arguments(command_config)
          if command_config.parameters?
            generate_indexed_arguments(command_config)
          elsif !command_config.parameters? && self.arguments
            generate_base_arguments(self.arguments)
          else
            generate_default_arguments
          end
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
        end

        def generate_indexed_arguments(command_config)
          Core::Bytes.new([self.id, *process_arguments(command_config, self)])
        end

        def generate_base_arguments(arguments)
          Core::Bytes.new([self.id, *arguments])
        end

        def generate_default_arguments
          Core::Bytes.new([self.id])
        end

        def process_arguments(command_config, command)
          index = command_config.index
          args = map_arguments(command, index)
          map_nested_arguments(args)
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
        end

        def map_arguments(command, index)
          values_with_index = index.map do |param, i|
            param_object = command.public_send(param)
            param_value = param_object.respond_to?(:value) ? param_object.value : param_object
            param_value ? [param_value, i] : nil
          end.compact

          values_with_index.sort_by! do |object|
            index = object[1]
            index.instance_of?(Range) ? index.first : index
          end

          values_with_index.map do |object|
            object[0]
          end
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
        end

        def map_nested_arguments(args)
          args.map do |d|
            if d.instance_of?(Array)
              array_of_bytes = d.map { |i| Core::Byte.new(i) }
              Core::Bytes.new(array_of_bytes)
            else
              Core::Byte.new(d)
            end
          end&.flatten
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
        end
      end
    end
  end
end
