# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    class Cache
      # Comment
      class Digital
        include Attributes
        attr_reader :attributes
        LENGTH = 7

        def initialize
          @attributes = generate_attributes(LENGTH)
        end

        def title
          attributes[0]
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
        LENGTH = 11

        def initialize
          @attributes = generate_attributes(LENGTH)
        end
      end

      # Comment
      class Titled
        include Attributes
        attr_reader :attributes
        LENGTH = 11

        def initialize
          @attributes = generate_attributes(LENGTH)
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
      class Static
        include Attributes
        attr_reader :attributes
        LENGTH = 5

        def initialize
          @attributes = generate_attributes(LENGTH)
        end

        def title_1
          attributes[8]
        end

        def title_2
          attributes[9]
        end
      end
    end
  end
end
