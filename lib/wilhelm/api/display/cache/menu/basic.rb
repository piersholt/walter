# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        module Menu
          # API::Display::Cache::Basic
          class Basic < Cache::Base
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
end
