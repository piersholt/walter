# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Map
      # Virtual::Map::Command
      class Command < Base
        include Singleton
        include Wilhelm::Helpers::DataTools
        include Helpers

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

        def schema?(mapped_result, ident)
          schema_listed?(mapped_result, ident) && schema_listed?(mapped_result, ident)
        end

        def schemas?(mapped_result)
          mapped_result.include?(:schemas)
        end

        def schema_listed?(mapped_result, ident)
          mapped_result[:schemas].include?(ident)
        end

        def schema_defined?(mapped_result, ident)
          mapped_result.include?(ident)
        end

        def fetch_schema(mapped_result, ident)
          mapped_result[ident]
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

          if (from || to) && schemas?(mapped_result)
            if schema?(mapped_result, from)
              mapped_result = fetch_schema(mapped_result, from)
            elsif schema?(mapped_result, to)
              mapped_result = fetch_schema(mapped_result, to)
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

        def thing
          map.map do |k, v|
            r = v.fetch(:parameters, nil)&.map do |pk, pv|
              [pk, pv[:type]]
            end&.to_h
            next unless r
            # g = r.group_by do |pk, pv|
            #   pv
            # end

            # u = r.values.uniq

            { k => r }
          end&.compact
        end

        def group
          map.group_by do |_, v|
            v.fetch(:parameters, nil)&.fetch(:type, nil)
          end
        end

        def types
          t = map.map do |id, command_hash|
            command_klasses = klasses(command_hash)
            [id, command_klasses]
          end

          t.map do |id, klasses|
            k = klasses.map do |klass|
              get_class(join_namespaces('Wilhelm::Virtual::Command', klass))
            end
            [id, *k]
          end
        end

        def klasses(hash)
          klass = hash[:klass]
          nested_klasses = hash[:schemas]&.map do |schema|
            klasses(hash[schema])
          end
          [klass, *nested_klasses]
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
