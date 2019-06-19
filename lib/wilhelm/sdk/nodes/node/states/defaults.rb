# frozen_string_literal: false

module Wilhelm
  module SDK
    class Node
      # Thingo
      module Defaults
        def open(___)
          false
        end

        def close(___)
          false
        end

        def online!(___)
          false
        end

        def establishing!(___)
          false
        end

        def offline!(___)
          false
        end
      end
    end
  end
end
