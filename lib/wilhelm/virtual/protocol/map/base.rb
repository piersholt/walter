# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Map
      # Virtual::Map::Base
      class Base
        PROG = 'Map::Base'.freeze

        DEFAULT_PATH      = ENV['map_path'].freeze
        DEFAULT_EXTENSION = '.yaml'.freeze

        ERROR_READ_MAP  = 'map is already read'.freeze
        ERROR_WRITE_MAP = 'map has not been read'.freeze
        ERROR_YAML      = 'yaml_data is false'.freeze

        FORCE_RELOAD = true

        def initialize(map_name)
          @name = map_name
          read_map(@name)
        end

        def find(key)
          LOGGER.debug(self.class.name) { "#find(#{key}) => #{key.class}" }
          search_key = key.respond_to?(:magnitude) ? key.magnitude : key
          raise(IndexError, "no object with key: #{key}") unless map.key?(search_key)
          map[search_key]
        end

        def map
          @map ||= read_map
        end

        # raise(error if there is pending changes
        def reload; end

        # what was the RoR method for a active record? #changed ?
        def stale?; end

        # reload file regardless of pending changes
        def reload!
          read_map(@name, FORCE_RELOAD)
        end

        # save file regardless of pending changes
        def save!
          write_map(@name)
        end

        private

        def map_name_as_path(map_name)
          base_path = DEFAULT_PATH
          filename = map_name
          file_ext = DEFAULT_EXTENSION

          "#{base_path}#{filename}#{file_ext}"
        end

        def read_map(map_name, force = false)
          raise(StandardError, ERROR_READ_MAP) unless @map.nil? || force
          LOGGER.debug(PROG) { "Reading map: #{map_name}" }
          file = File.open(map_name_as_path(map_name))
          parsed_yaml = parse_yaml_from_file(file)
          @map = parsed_yaml
          true
        end

        def write_map(map_name)
          raise(StandardError, ERROR_WRITE_MAP) if @map.nil?

          file = File.open(map_name_as_path(map_name), 'w')

          yaml_buffer = YAML.dump(map)
          file.write_nonblock(yaml_buffer)

          true
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
        end

        def parse_yaml_from_file(file)
          yaml_buffer = file.read
          yaml_data = YAML.load(yaml_buffer)
          raise(StandardError, ERROR_YAML) if yaml_data == false
          yaml_data
        end
      end
    end
  end
end
