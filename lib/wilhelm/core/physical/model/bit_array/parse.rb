# frozen_string_literal: false

module Wilhelm
  module Core
    class BitArray
      # Virtual::BitArray::Parse
      module Parse
        include Wilhelm::Helpers::DataTools

        PARSE_MAP = {
          Integer => :parse_integer,
          String => :parse_string
        }.freeze

        ERROR_LENGTH = 'Binary data failure'.freeze

        def self.from_i(object)
          bit_array = BitArray.new
          parse_method = PARSE_MAP[object.class]
          raise(ArgumentError, 'no class to method key!') unless parse_method
          bit_array.public_send(parse_method, object)
          bit_array
        end

        def parse_integer(integer)
          binary_string = d2b(integer)
          parse_string(binary_string)
        end

        def parse_string(binary_string)
          # TODO: pad to bytes
          # raise(RangeError, ERROR_LENGTH) if binary_string.length > 8
          @bits = binary_string.each_char.map(&:to_i)
        end
      end
    end
  end
end
