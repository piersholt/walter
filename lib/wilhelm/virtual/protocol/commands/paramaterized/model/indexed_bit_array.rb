# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Virtual::IndexedBitArray
    class IndexedBitArray < BitArray
      include Wilhelm::Helpers::PositionalNotation
      PROG = 'IndexedBitArray'.freeze

      def initialize(bit_array = nil, index = nil)
        super(bit_array)
        @index = index
      end

      def add_index(index)
        @index = index
      end

      def lookup(name)
        LOGGER.debug(PROG) { "#lookup(#{name})" }
        LOGGER.warn(PROG) { "name is nil!" } unless name
        parameter_index = index_as_range(name)
        bits = @bits.slice(parameter_index)
        LOGGER.warn(PROG) { "bits is nil!" } unless bits
        parse_base_2_digits(*bits)
        # it was fog_front!
      rescue TypeError => e
        LOGGER.error(PROG) { e }
        e.backtrace.each { |line| LOGGER.error(PROG) { line } }
        binding.pry
      end

      def parameters
        @index.keys
      end

      private

      def index_as_range(name)
        parameter_index = @index[name]
        return parameter_index if parameter_index.instance_of?(Range)
        Range.new(parameter_index, parameter_index)
      end
    end
  end
end
