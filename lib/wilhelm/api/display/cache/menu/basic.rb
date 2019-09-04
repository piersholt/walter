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
            NAME = 'Cache::Basic'

            def initialize
              super(LENGTH, INDEX_START)
            end
          end
        end
      end
    end
  end
end
