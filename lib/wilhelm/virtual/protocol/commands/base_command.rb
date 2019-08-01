# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Basic device class
      class BaseCommand
        module Raw
          PROG = 'Raw'

          def command_config(from, to)
            @config ||= get_command_config(from, to)
          end

          def get_command_config(from, to)
            # HACK yeah this is fucking awful. See Multiplexer and API::Base.
            c = CommandMap.instance.config(
              id.d,
              from: resolve_address(from),
              to: resolve_address(to)
            )
            raise(StandardError, "#get_command_config(#{id.d}) => No command_config #{id}") unless c
            c
          end

          def resolve_address(device_id)
            AddressLookupTable.instance.resolve_address(device_id)
          end

          def raw
            LOGGER.debug(PROG) { '#raw' }
            raise(StandardError, "#config() => No command_config #{id}") unless @config
            if @config.has_parameters?
              index = @config.index
              Core::Bytes.new([id, *process_arguments(self, index)])
            elsif !@config.has_parameters? && self.arguments
              Core::Bytes.new([id, *arguments])
            else
              Core::Bytes.new([id])
            end
          rescue StandardError => e
            LOGGER.error(PROG) { e }
            LOGGER.error(PROG) { "ID: #{id}, ID Decimal: #{id.d}" }
            e.backtrace.each { |l| LOGGER.error(PROG) { l } }
          end

          def process_arguments(command, index)
            args = map_arguments(command, index)

            nested_arguments = args.map do |d|
              if d.instance_of?(Array)
                array_of_bytes = d.map { |i| Core::Byte.new(:decimal, i) }
                Core::Bytes.new(array_of_bytes)
              else
                Core::Byte.new(:decimal, d)
              end
            end
            nested_arguments.flatten
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
          end
        end

        include Wilhelm::Helpers::DataTools
        include Helpers
        include Raw

        PADDED_DEFAULT = true

        attr_accessor :id, :short_name, :long_name, :arguments, :verbose

        alias :address :id
        alias :ln :long_name
        alias :args :arguments

        def initialize(id, props)
          LOGGER.debug("BaseCommand") { "#initialize(#{id}, #{props})" }
          @id = id
          set_properties(props)
        end

        def normal_fucking_decimal
          id.d
        end

        def ==(other_command)
          self.d == other_command.d
        end

        # -------------------------------- OBJECT ------------------------------- #

        def to_s
          return inspect if @verbose
          abvr = short_name == '???' ? h : short_name
          str_buffer = sprintf("%-10s", abvr)
          args_str_buffer = @arguments.map(&:h).join(' ')
          str_buffer.concat("\t#{args_str_buffer}") unless args_str_buffer.empty?
          str_buffer.concat("\t--") if args_str_buffer.empty?
          str_buffer
        end

        def inspect
          str_buffer = sprintf("%-10s", sn)
          args_str_buffer = @arguments.map(&:h).join(' ')
          str_buffer.concat("\t#{args_str_buffer}") unless args_str_buffer.empty?
          str_buffer.concat("--") if args_str_buffer.empty?
          str_buffer
        end

        # ----------------------------- PROPERTIES ------------------------------ #

        def d
          @id.d
        end

        def b
          @id.b
        end

        def h
          @id.h
        end

        def sn(padded = PADDED_DEFAULT)
          padded ? sprintf("%-10s", short_name) : short_name
        end

        def set_parameters(params)
          set_properties(params)
        end

        private

        def set_properties(props)
          props.each do |name, value|
            instance_variable_set(inst_var(name), value)
          end
        end
      end
    end
  end
end
