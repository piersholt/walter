# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Comment
      class Cache
        # Comment
        class Basic < BaseCache
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
end
