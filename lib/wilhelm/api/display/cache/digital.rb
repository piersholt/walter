# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Comment
      class Cache
        # Comment
        class Digital < BaseCache
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
end
