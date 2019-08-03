# frozen_string_literal: false

require_relative 'parameterized/delegated'

module Wilhelm
  module Virtual
    class Command
      class Builder
        # For command classes that have parameters
        class Parameterized < Builder
          include Delegated

          PROG = 'Builder::Parameterized'.freeze

          # @override Builder.add_parameters
          def add_parameters(parameter_value_hash)
            LOGGER.debug(PROG) { "#add_parameters(#{parameter_value_hash})" }
            @command_config.parameters.each do |param_name, param_config|
              param_value = parameter_value_hash[param_name]
              param_object = parse_parameter(param_name, param_config, param_value)
              add_parameter(param_name, param_object)
            end
          end

          def result
            LOGGER.debug(PROG) { "#result" }
            command_klass = @command_config.klass_constant

            command_id  = @command_config.id
            properties  = @command_config.properties_hash

            command_object = command_klass.new(command_id, properties)
            @command_config.configure(command_object)
            # command_object.set_parameters(@parameter_objects)
            @parameter_objects.each do |k, v|
              command_object.instance_variable_set(inst_var(k), v)
            end

            command_object
          end

          private

          def parse_parameter(param_name, param_config, param_value)
            LOGGER.debug(PROG) { "#parse_parameter(#{param_name}, #{param_config}, #{param_value})" }
            param_type  = param_config.type

            param_object = delegate(param_config, param_type, param_value)
            param_config.configure(param_object)

            param_object
          end

          def add_parameter(param_name, param_object)
            LOGGER.debug(PROG) { "#add_parameter(#{param_name}, #{param_object})" }
            @parameter_objects[param_name] = param_object
          end
        end
      end
    end
  end
end
