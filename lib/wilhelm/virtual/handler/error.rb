# frozen_string_literal: true

module Wilhelm
  module Virtual
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
