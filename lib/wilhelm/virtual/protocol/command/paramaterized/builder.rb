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

          LOG_RESULT = '#result'.freeze

          # @override Builder.add_parameters
          def add_parameters(parameter_value_hash)
            LOGGER.debug(PROG) { "#add_parameters(#{parameter_value_hash})" }
            @command_config.parameters.each do |param_name, param_config|
              next if parameter_value_hash[param_name]&.empty? && param_config.type == :map
              @parameter_objects[param_name] = parse_parameter(param_name, param_config, parameter_value_hash[param_name])
            end
          end

          def result
            LOGGER.debug(PROG) { LOG_RESULT }
            command_object = create_command_object

            @command_config.configure(command_object)
            command_object.add_properties(@parameter_objects)

            command_object
          end

          private

          def parse_parameter(param_name, param_config, param_value)
            LOGGER.debug(PROG) { "#parse_parameter(#{param_name}, #{param_config}, #{param_value})" }
            param_type = param_config.type

            param_object = delegate(param_config, param_type, param_value)
            param_config.configure(param_object)

            param_object
          end
        end
      end
    end
  end
end
