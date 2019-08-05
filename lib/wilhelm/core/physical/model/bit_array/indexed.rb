# frozen_string_literal: false

module Wilhelm
  module Core
    class BitArray
      # Virtual::BitArray::Indexed
      module Indexed
        include Wilhelm::Helpers::PositionalNotation

        PROG = 'BitArray::Indexed'.freeze

        ERROR_INDEX_NIL   = 'index is nil!'.freeze
        ERROR_NAME        = 'name is nil!'.freeze
        ERROR_INDEX_RANGE = 'param_range is nil!'.freeze
        ERROR_BITS        = 'bits is nil!'.freeze
        ERROR_INDEX_NAME  = 'index does not contain '.freeze

        attr_reader :index

        def lookup(name)
          LOGGER.debug(PROG) { "#lookup(#{name})"}
          index? & name?(name)

          param_range = index_as_range(name)
          param_range?(param_range)

          bits = @bits.slice(param_range)
          bits?(bits)

          parse_base_2_digits(*bits)
        rescue TypeError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          binding.pry
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

        def bits?(bits)
          return true if bits
          raise(StandardError, ERROR_BITS)
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
      end
    end
  end
end
