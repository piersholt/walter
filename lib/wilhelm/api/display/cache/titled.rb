# frozen_string_literal: true

class Wilhelm::API
  class Display
    # Comment
    class Cache
      # Comment
      class Titled < BaseCache
        INDEX_START = 0
        LENGTH = 11
        TITLE_LEFT_INDEX = 9
        TITLE_RIGHT_INDEX = 10

        def initialize
          @attributes = generate_attributes(LENGTH, INDEX_START)
        end

        def name
          'Cache (Titled)'
        end

        def title_left
          attributes[TITLE_LEFT_INDEX]
        end

        def title_right
          attributes[TITLE_RIGHT_INDEX]
        end

        alias tl title_left
        alias tr title_right
      end
    end
  end
end
