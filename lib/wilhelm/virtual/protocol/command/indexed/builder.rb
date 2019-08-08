# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      class Builder
        module Indexed
          # Virtual::Command::Builder::Indexed
          class Builder < Command::Builder
            include Helpers

            PROG = 'Indexed::Builder'.freeze

            LOG_RESULT = '#result'.freeze

            # @override Command::Builder.add_parameters
            def add_parameters(parameter_value_hash)
              LOGGER.debug(PROG) { "#add_parameters(#{parameter_value_hash})" }
              @parameter_objects = parameter_value_hash
            end

            def result
              LOGGER.debug(PROG) { LOG_RESULT }
              create_command_object(@parameter_objects)
            end
          end
        end
      end
    end
  end
end
