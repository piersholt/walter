# frozen_string_literal: false

module Wilhelm
  module Core
    class Bytes
    # Core::Bytes::Indexed
    module Indexed
      PROG = 'Bytes::Indexed'.freeze

      ERROR_INDEX_NIL   = 'index is nil!'.freeze
      ERROR_NAME        = 'name is nil!'.freeze
      ERROR_INDEX_RANGE = 'param_range is nil!'.freeze
      ERROR_BYTES       = 'bits is nil!'.freeze
      ERROR_INDEX_NAME  = 'index does not contain '.freeze

      attr_reader :index

      def lookup(name)
        LOGGER.debug(PROG) { "#lookup(#{name})" }
        index? & name?(name)

        param_range = index_as_range(name)
        param_range?(param_range)

        bytes = array.slice(param_range)
        bytes?(bytes)
        bytes = Core::Bytes.new(bytes) if bytes.is_a?(Array)
        return bytes if bytes
        default(name, param_range)
      end

      def add_index(index)
        @index = index
      end

      def parameters
        @index.keys
      end

      def index?
        return true if @index
        raise(ArgumentError, ERROR_INDEX_NIL)
      end

      def name?(name)
        return true if name
        raise(ArgumentError, ERROR_NAME)
      end

      def param_range?(param_range)
        return true if param_range
        raise(StandardError, ERROR_INDEX_RANGE)
      end

      def bytes?(bytes)
        return true if bytes
        raise(StandardError, ERROR_BYTES)
      end

      def index_name?(name)
        return true if @index.key?(name)
        raise(ArgumentError, error_index_name(name))
      end

      def error_index_name(name)
        "#{ERROR_INDEX_NAME} #{name}! (#{@index.keys})"
      end

      private

      def index_as_range(name)
        index_name?(name)
        param_range = @index[name]
        return param_range if param_range.instance_of?(Range)
        Range.new(param_range, param_range)
      end

      def default(name, param_range)
        LOGGER.warn(PROG) { "#{name} was nil! Returning default value." }
        case param_range
        when Integer
          default_integer
        when Range
          default_range(param_range)
        end
      end

      def default_integer
        0
      end

      def default_range(param_range)
        if param_range.max.nil?
          Core::Bytes(Array.new(1, 0))
        else
          Core::Bytes(Array.new(param_range.size, 0))
        end
      end
    end
    end
  end
end
