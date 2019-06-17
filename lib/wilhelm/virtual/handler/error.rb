# frozen_string_literal: true

module Wilhelm
  class Virtual
    module Handler
      # Comment
      class RoutingError < StandardError
        def message
          'A routing error has occured!'
        end
      end
    end
  end
end
