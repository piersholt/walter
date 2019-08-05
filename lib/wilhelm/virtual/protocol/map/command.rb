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

        INVALID_ID    = ':id missing!'.freeze
        INVALID_KLASS = ':klass missing!'.freeze

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
            mapped_result = find(0)
          end

          if from || to
            schemas = mapped_result[:schemas]
            if schemas
              mapped_result = mapped_result[from] if schemas.include?(from)
              mapped_result = mapped_result[to] if schemas.include?(to)
            end
          end

          mapped_result[:id] = command_id

          Virtual::Command::Configuration.new(mapped_result)
        end

        alias config find_or_default

        def valid?
          valid_ids?
          valid_klasses?
          true
        end

        private

        def valid_ids?
          return true if map.values.all? { |c| c.key?(:id) }
          errors = map.find_all { |_, v| !v.key?(:id) }&.map { |k, _| k }
          raise(IOError, invalid_id(errors))
        end

        def valid_klasses?
          return true if map.values.all? { |c| c.key?(:klass) }
          errors = map.find_all { |_, v| !v.key?(:klass) }&.map { |k, _| k }
          raise(IOError, invalid_klass(errors))
        end

        def invalid_id(errors)
          INVALID_ID + errors.to_s
        end

        def invalid_klass(errors)
          INVALID_KLASS + errors.to_s
        end
      end
    end
  end
end
