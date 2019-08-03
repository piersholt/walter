# frozen_string_literal: false

require_relative 'command_configuration/klass'

module Wilhelm
  module Virtual
    # Virtual::CommandConfiguration
    class CommandConfiguration
      include Helpers
      include Klass

      PROC = 'CommandConfig'.freeze

      MAP       = :map
      SWITCH    = :switch
      BIT_ARRAY = :bit_array
      TYPES     = [MAP, BIT_ARRAY, SWITCH].freeze

      SCOPE                 = 'Wilhelm::Virtual'.freeze
      NAMESPACE             = 'Command'.freeze
      BASE                  = 'BaseCommand'.freeze
      PARAMETERIZED         = 'ParameterizedCommand'.freeze
      BUILDER_BASE          = 'BaseCommandBuilder'.freeze
      BUILDER_PARAMETERIZED = 'ParameterizedCommandBuilder'.freeze
      WRAPPER               = ParameterConfiguration

      LOG_METHOD_INITIALIZE = '#initialize'.freeze

      attr_reader :parameters

      def initialize(mapped_command)
        LOGGER.debug(PROC) { LOG_METHOD_INITIALIZE }
        @command_hash = mapped_command.dup

        parse_parameters(parameters_hash) if parameters?
        configure_class unless configured?
      end

      def inspect
        "<#{PROC} @id=#{id} @sn=#{sn} @klass=#{klass} @has_parameters=#{parameters?} @parameter_list=#{parameter_list}>"
      end

      def logger
        LOGGER
      end

      # Initialization -------------------------------------------------------

      def parse_parameters(mapped_parameters)
        LOGGER.debug(PROC) { "#parse_parameters(#{mapped_parameters})" }
        @parameters = {}
        mapped_parameters.each do |name, data|
          new_parameter =
            if data[:type] == BIT_ARRAY
              BitArrayParameterConfiguration.new(name, data)
            else
              ParameterConfiguration.new(name, data)
            end
          @parameters[name] = new_parameter
        end
      end

      # Command Hash ----------------------------------------------------------

      def id
        @command_hash[:id]
      end

      def properties_hash
        @command_hash[:properties]
      end

      def klass
        @command_hash[:klass]
      end

      def index
        @command_hash[:index]
      end

      def parameters_hash
        @command_hash[:parameters]
      end

      # Configuration ---------------------------------------------------------

      def sn
        properties_hash[:short_name]
      end

      def base?
        klass == BASE
      end

      def klass_constant
        get_class(join_namespaces(SCOPE, NAMESPACE, klass))
      end

      def parameterized_command
        get_class(join_namespaces(SCOPE, NAMESPACE, PARAMETERIZED))
      end

      def parameterized?
        result = klass_constant <= parameterized_command
        result = result.nil? ? false : result
        LOGGER.debug(PROC) { "#{klass_constant} <= #{parameterized_command} => #{result}" }
        result
      end

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
          get_class(join_namespaces(SCOPE, BUILDER_BASE))
        elsif parameters?
          get_class(join_namespaces(SCOPE, BUILDER_PARAMETERIZED))
        else
          get_class(join_namespaces(SCOPE, BUILDER_BASE))
        end
      end

      # Object Configuration --------------------------------------------------

      def configure(command_object)
        LOGGER.debug(PROC) { "Configure command #{command_object.class}" }
        command_object.instance_variable_set(inst_var(:parameters), parameter_list)
      end
    end
  end
end
