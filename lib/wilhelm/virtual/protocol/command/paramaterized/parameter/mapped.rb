# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Virtual::MappedParameter
    class MappedParameter < BaseParameter
      PROC = 'MappedParameter'.freeze

      PRETTY_VALUE_NIL = '--'.freeze
      DICTIONARY_NIL   = '@dictionary is nil!'.freeze
      MAP_NIL          = '@map is nil!'.freeze
      WARN_DICT_NIL    = 'Map @dictionary is nil!'.freeze
      WARN_MAP_NIL     = 'Map @map is nil!'.freeze
      ERROR_VALUE_NIL  = '#ugly: value is nil!'.freeze

      MASK_LABEL = "%-#{DEFAULT_LABEL_WIDTH}s".freeze

      attr_accessor :map, :dictionary, :label
      alias states map

      def initialize(configuration, integer)
        super(configuration, *integer)
      end

      def inspect
        "<#{PROC} @value=#{value}>"
      end

      def to_s
        str_buffer = ''
        str_buffer.concat(format(MASK_LABEL, label)) if label
        str_buffer.concat(LABEL_DELIMITER) if label
        str_buffer.concat(pretty.to_s)
      end

      def ugly
        raise(ArgumentError, ERROR_VALUE_NIL) unless value
        if @map.nil?
          LOGGER.warn(PROC) { WARN_MAP_NIL }
          MAP_NIL
        elsif !@map.key?(value)
          value_not_found(value)
        else
          @map[value]
        end
      end

      alias to_sym ugly

      def pretty
        return PRETTY_VALUE_NIL unless value
        if @dictionary.nil?
          LOGGER.warn(PROC) { WARN_DICT_NIL }
          DICTIONARY_NIL
        elsif !@dictionary.key?(value)
          value_not_found(value)
        else
          @dictionary[value]
        end
      end

      def value_not_found(value)
        "#{d2h(value, true)} not found!"
      end
    end
  end
end
