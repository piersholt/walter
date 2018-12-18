# frozen_string_literal: true

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
      array_of_bytes = decimal_array.map { |int| Byte.new(:decimal, int) }
      Bytes.new(array_of_bytes)
    end
  end
end
