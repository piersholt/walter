# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        module Menu
          # API::Display::Cache::Titled
          class Titled < Cache::Base
            INDEX_START = 0
            LENGTH = 11
            TITLE_LEFT_INDEX = 9
            TITLE_RIGHT_INDEX = 10
            NAME = 'Cache::Titled'

            def initialize
              super(LENGTH, INDEX_START)
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
  end
end
