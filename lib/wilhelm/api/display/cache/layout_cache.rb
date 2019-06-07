# frozen_string_literal: true

class Vehicle
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

class Vehicle
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

      # Comment
      class Titled
        include Attributes
        attr_reader :attributes
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

class Vehicle
  class Display
    # Comment
    class Cache
      # Comment
      class Static
        include Attributes
        attr_reader :attributes
        INDEX_START = 0
        LENGTH = 6

        def initialize
          @attributes = generate_attributes(LENGTH, INDEX_START)
        end

        def name
          'Cache (Static)'
        end
      end
    end
  end
end
