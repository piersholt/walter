# frozen_string_literal: false

require_relative 'builder/delegated'

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # For command classes that have parameters
        class Builder < Command::Builder
          include Delegated

          PROG = 'Parameterized::Builder'.freeze

          # @override Builder.add_parameters
          def add_parameters(parameter_value_hash)
            LOGGER.debug(PROG) { "#add_parameters(#{parameter_value_hash})" }
            @command_config.parameters.each do |param_name, param_config|
              @parameter_objects[param_name] = parse_parameter(param_name, param_config, parameter_value_hash[param_name])
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
        end
      end
    end
  end
end
