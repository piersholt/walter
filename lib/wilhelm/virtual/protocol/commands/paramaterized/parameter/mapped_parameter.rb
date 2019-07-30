# frozen_string_literal: false

module Wilhelm
  module Virtual
    class MappedParameter < BaseParameter
      PROC = 'MappedParameter'.freeze

      attr_accessor :map, :dictionary, :label
      def initialize(configuration, integer)
        super(configuration, integer)
      end

      def inspect
        "<#{PROC} @value=#{value}>"
      end

      def to_s(width = DEFAULT_LABEL_WIDTH)
        str_buffer = ''
        str_buffer.concat(format("%-#{width}s", "#{label}")) if label
        str_buffer.concat(LABEL_DELIMITER) if label
        str_buffer.concat(pretty.to_s)
      end

      def ugly
        if value.nil?
          raise ArgumentError, 'No map to get ugly :map'
        elsif @map.nil?
          LOGGER.warn(PROC) { "Map @map is nil!" }
          return "\"value\""
        elsif !@map.key?(value)
          return "#{d2h(value, true)} not found!"
        else
          @map[value]
        end
      end

      alias to_sym ugly

      def pretty
        if value.nil?
          return '--'
        elsif @dictionary.nil?
          LOGGER.warn(PROC) { "Map @dictionary is nil!" }
          return "\"value\""
        elsif !@dictionary.key?(value)
          return "#{d2h(value, true)} not found!"
        else
          @dictionary[value]
        end
      end
    end
  end
end
