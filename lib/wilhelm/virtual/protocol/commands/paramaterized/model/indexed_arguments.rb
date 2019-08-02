# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Comment
    class IndexedArguments < Core::Bytes
      PROG = 'IndexedArguments'.freeze

      def initialize(bytes, index)
        super(bytes)
        @index = index
      end

      def lookup(name)
        parameter_index = @index[name]
        # @note DSP-SET does not always have second arg...
        d[parameter_index] || default(name, parameter_index)
      end

      def parameters
        @index.keys
      end

      def to_s
        "#{PROG}: Index: #{@index}, Bytes: #{super}"
      end

      def inspect
        to_s
      end

      private

      def default(name, parameter_index)
        LOGGER.warn(PROG) { "#{name} was nil! Returning default value." }
        case parameter_index
        when Integer
          default_integer
        when Range
          default_range(parameter_index)
        end
      end

      def default_integer
        0
      end

      def default_range(parameter_index)
        if parameter_index.max.nil?
          Array.new(1, 0)
        else
          Array.new(parameter_index.size, 0)
        end
      end
    end
  end
end
