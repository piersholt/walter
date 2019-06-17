# frozen_string_literal: true

class Wilhelm::API
  class Display
    # Comment
    class Cache
      # Comment
      class Digital
        include Attributes
        attr_reader :attributes
        INDEX_START = 0
        LENGTH = 9

        def initialize
          @attributes = generate_attributes(LENGTH, INDEX_START)
        end

        def title
          attributes[0]
        end

        def name
          'Cache (Digital)'
        end
      end
    end
  end
end
