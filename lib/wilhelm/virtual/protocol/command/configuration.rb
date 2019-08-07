# frozen_string_literal: false

require_relative 'configuration/constants'
require_relative 'configuration/klass'
require_relative 'configuration/parameter'
require_relative 'configuration/bit_array'

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Configuration
      class Configuration
        include Constants
        include Klass

        def initialize(mapped_command)
          LOGGER.debug(PROC) { LOG_METHOD_INITIALIZE }
          @command_hash = mapped_command.dup

          create_param_config_map(parameters_hash) if parameters?
          configure_class
        end

        def inspect
          "<#{PROC} @id=#{id} @sn=#{sn} @klass=#{klass} " \
          "index?=>#{index?} parameters?=>#{parameters?} " \
          "index_keys=>#{index_keys} parameter_keys=#{parameter_keys}>"
        end

        # Initialization -------------------------------------------------------

        def parse_parameters(mapped_parameters)
          LOGGER.debug(PROC) { "#parse_parameters(#{mapped_parameters})" }
          @parameters = {}
          mapped_parameters.each do |name, data|
            new_parameter =
            if data[:type] == BIT_ARRAY
              Configuration::BitArray.new(name, data)
            else
              Configuration::Parameter.new(name, data)
            end
            @parameters[name] = new_parameter
          end
        end

        # Command Hash --------------------------------------------------------

        def id
          @command_hash[:id]
        end

        def schemas_array
          @command_hash[:schemas]
        end

        def properties_hash
          @command_hash[:properties]
        end

        def klass
          @command_hash[:klass]
        end

        def parameters_index
          @command_hash[:index]
        end

        alias index parameters_index

        def parameters_hash
          @command_hash[:parameters]
        end

        # Configuration -------------------------------------------------------

        def schemas
          return [] unless schemas?
          schemas_array
        end

        def schemas?
          return false unless schemas_array
          true
        end

        def short_name
          properties_hash[:short_name]
        end

        alias sn short_name

        def klass_constant
          get_class(join_namespaces(NAMESPACE, klass))
        end

        def base_command
          get_class(join_namespaces(NAMESPACE, BASE))
        end

        def base_command?
          klass == BASE
        end

        alias base? base_command?

        def parameterized_command
          get_class(join_namespaces(NAMESPACE, PARAMETERIZED))
        end

        def parameterized_command?
          result = klass_constant <= parameterized_command
          result = result.nil? ? false : result
          LOGGER.debug(PROC) { "#{klass_constant} <= #{parameterized_command} => #{result}" }
          result
        end

        alias parameterized? parameterized_command?

        def parameters?
          parameters_hash.nil? ? false : true
        end

        def parameter_list
          parameters_hash.keys
        end

        def bit_arrays?
          return false unless parameters?
          parameters.any? { |_, data| data.type == BIT_ARRAY }
        end

        def builder
          if parameters? && base?
            get_class(join_namespaces(NAMESPACE, BASE_BUILDER))
          elsif parameters?
            get_class(join_namespaces(NAMESPACE, PARAMETERIZED_BUILDER))
          else
            get_class(join_namespaces(NAMESPACE, BASE_BUILDER))
          end
        end
      end
    end
  end
end
