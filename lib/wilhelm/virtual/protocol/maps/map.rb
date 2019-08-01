# frozen_string_literal: false

# what's the point of the map?
# it alows me to dynamically instantiate a class
# that represents a given ibus model (device, command..)

# fuck.. am i.. loading the specific class type MappedCommand...
# Map is generic.. but there's no reason the results

module Wilhelm
  module Virtual
    # Virtual::BaseMap
    class BaseMap
      DEFAULT_BASE_PATH = ENV['map_path'].freeze
      DEFAULT_FILE_EXTENSSION = '.yaml'.freeze
      FORCE_RELOAD = true
      PROG = 'BaseMap'.freeze

      def initialize(map_name)
        @name = map_name
        read_map(@name)
      end

      def find(key)
        # LOGGER.debug("#{self.class.superclass}") { "#find(#{key})" }
        raise(IndexError, "no objet with key #{key}") unless map.key?(key)
        map[key]
      end

      def map
        @map ||= read_map
      end

      # raise(error if there is pending changes
      def reload
      end

      # what was the RoR method for a active record? #changed ?
      def stale?
      end

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
        base_path = DEFAULT_BASE_PATH
        filename = map_name
        file_ext = DEFAULT_FILE_EXTENSSION

        "#{base_path}#{filename}#{file_ext}"
      end

      def read_map(map_name, force = false)
        raise(StandardError, 'map is already read') unless @map.nil? || force
        LOGGER.debug(PROG) { "Reading map: #{map_name}" }
        file = File.open(map_name_as_path(map_name))
        parsed_yaml = parse_yaml_from_file(file)
        @map = parsed_yaml
        true
      end

      def write_map(map_name)
        raise(StandardError, 'map has not been read') if @map.nil?

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
        raise(StandardError, 'yaml_data is false') if yaml_data == false
        yaml_data
      end
    end
  end
end
