# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Comment
      class Cache
        # Comment
        class Static < BaseCache
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
end
