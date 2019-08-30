# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        module Header
          # API::Display::Cache::Digital
          class Digital < Base
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
end
