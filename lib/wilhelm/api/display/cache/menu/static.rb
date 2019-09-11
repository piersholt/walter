# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        module Menu
          # API::Display::Cache::Static
          class Static < Cache::Base
            INDEX_START = 1
            LENGTH = 5
            NAME = 'Cache::Static'

            def initialize
              super(LENGTH, INDEX_START)
            end
          end
        end
      end
    end
  end
end
