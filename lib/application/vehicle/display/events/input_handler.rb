# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module InputHandler
      NAME = 'InputHandler'

      def input_confirm(properties)
        user_input(:input_confirm, properties)
      end

      def input_select(properties)
        user_input(:select_item, properties)
      end

      def input_left(value)
        # user_input(:input_left, value)
      end

      def input_right(value)
        # user_input(:input_right, value)
      end
    end
  end
end
