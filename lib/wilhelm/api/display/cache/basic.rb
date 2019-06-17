# frozen_string_literal: true

class Wilhelm::API
  class Display
    # Comment
    class Cache
      # Comment
      class Basic
        include Attributes
        attr_reader :attributes
        INDEX_START = 0
        LENGTH = 11

        def initialize
          @attributes = generate_attributes(LENGTH, INDEX_START)
        end

        def name
          'Cache (Basic)'
        end
      end
    end
  end
end
