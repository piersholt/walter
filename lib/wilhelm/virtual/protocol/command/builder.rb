# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Builder
      class Builder
        include Helpers

        PROG = 'Builder'.freeze

        def initialize(command_config)
          @command_config = command_config
          @parameter_objects = {}
        end

        def add_parameters(byte_stream)
          @arguments = byte_stream
        end

        def result
          LOGGER.debug(PROG) { '#result' }
          create_command_object(arguments: @arguments)
        end

        protected

        def create_command_object(arguments = {})
          command_klass = @command_config.klass_constant

          command_id  = @command_config.id
          properties  = @command_config.properties_hash

          command_klass.new(command_id, properties, arguments)
        end
      end
    end
  end
end
