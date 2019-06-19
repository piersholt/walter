# frozen_string_literal: false

module Wilhelm
  class Virtual
    module Capabilities
      module Helpers
        # @deprecated alias
        def integers(*arguments)
          integers_input(*arguments)
        end

        # @deprecated alias
        def array(arguments)
          integer_array_input(arguments)
        end

        def integer_array_input(arguments)
          bytes(arguments)
        end

        def integers_input(*arguments)
          bytes(arguments)
        end

        def bytes(decimal_array)
          array_of_bytes = decimal_array.map { |int| Wilhelm::Core::Byte.new(:decimal, int) }
          Bytes.new(array_of_bytes)
        end

        def generate_ints(length = 1)
          Array.new(length) do
            Random.rand(0..9)
          end.join
        end

        def generate_chars(length = 20, range = 0x21..0x7a)
          Array.new(length) do
            Random.rand(range).chr
          end.join
        end

        def delimitered_chars(delimiter = 6, items = 2)
          items.times.map do
            "#{delimiter.chr}#{genc(5)}"
          end.join
        end

        def integer_array_to_chars(array)
          array.map {|i| i.chr }.join
        end

        def wait
          Kernel.sleep(0.01)
        end

        alias genc generate_chars
        alias geni generate_ints
      end
    end
  end
end
