# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class BaseListener
      include Observable
      include Constants::Events

      def name
        self.class.name
      end
    end
  end
end
