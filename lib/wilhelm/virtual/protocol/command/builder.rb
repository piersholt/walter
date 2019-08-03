# frozen_string_literal: false

require_relative 'builder/parameterized'

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
          command_klass = @command_config.klass_constant

          command_id  = @command_config.id
          properties  = @command_config.properties_hash
          properties[:arguments] = @arguments

          command_object = command_klass.new(command_id, properties)
          # command_object.set_parameters(@parameter_objects)

          command_object
        end
      end
    end
  end
end
