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

          parse_parameters(parameters_hash) if parameters?
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

        def index_hash
          @command_hash[:index]
        end

        alias index index_hash
        alias parameters_index index_hash

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

        # Properties

        def short_name
          properties_hash[:short_name]
        end

        alias sn short_name

        # Klass

        def klass_constant
          get_class(join_namespaces(NAMESPACE, klass))
        end

        alias config_command klass_constant

        def base_command?
          klass == BASE
        end

        alias base? base_command?

        def indexed_command?
          !base_command? && !parameterized_command?
        end

        def parameterized_command?
          r = config_command <= parameterized_command
          return r if r
          LOGGER.warn(PROC) { 'parameterized_command? => nil!' }
          false
        end

        alias parameterized? parameterized_command?

        # Index

        def index?
          index_hash.nil? ? false : true
        end

        def index_list
          return [] unless index?
          index_hash.keys
        end

        alias index_keys index_list

        # Parameters

        def param_config_map
          @parameters || {}
        end

        alias parameters param_config_map

        def parameters?
          parameters_hash.nil? ? false : true
        end

        def parameter_list
          return [] unless parameters?
          parameters_hash.keys
        end

        alias parameter_keys parameter_list

        # Parameters: BitArray

        def bit_arrays?
          return false unless parameters?
          parameters.any? { |_, data| data.type == BIT_ARRAY }
        end

        def builder
          if base_command?
            base_builder
          elsif indexed_command? && index? && !parameters?
            indexed_builder
          elsif indexed_command? && index? && parameters?
            LOGGER.warn(PROC) { "#{sn}: Indexed, but has paramters!" }
            parameterized_builder
          elsif parameterized_command? && parameters?
            parameterized_builder
          else
            default_builder
          end
        end
      end
    end
  end
end
