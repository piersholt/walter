# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Map
      # Virtual::Map::Command
      class Command < Base
        include Singleton
        include Wilhelm::Helpers::DataTools

        PROC = 'Map::Command'.freeze
        COMMANDS_MAP_NAME = 'commands'.freeze

        def initialize(map = COMMANDS_MAP_NAME)
          super(map)
        end

        def self.reload!
          instance.reload!
        end

        def find_or_default(command_id, from: nil, to: nil)
          LOGGER.debug(PROC) { "#find_or_default(#{command_id})" }
          mapped_result = nil

          begin
            mapped_result = find(command_id)
          rescue IndexError
            LOGGER.error(PROC) do
              "Command ID: #{command_id}, #{d2h(command_id, true)} not found!"
            end
            mapped_result = find(:default)
            mapped_result[:id] = command_id
          end

          if from || to
            schemas = mapped_result[:schemas]
            if schemas
              mapped_result = mapped_result[from] if schemas.include?(from)
              mapped_result = mapped_result[to] if schemas.include?(to)
            end
          end

          Virtual::Command::Configuration.new(mapped_result)
        end

        alias config find_or_default
      end
    end
  end
end
