# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module InputHandler
      NAME = 'InputHandler'

      def input_confirm(properties)
        user_input(:input_confirm, properties)
      end

      def input_next(properties)
        user_input(:input_next, properties)
      end

      def input_prev(properties)
        user_input(:input_prev, properties)
      end

      def data_select(properties)
        user_input(:data_select, properties)
      end

      def input_left(value)
        # user_input(:input_left, value)
      end

      def input_right(value)
        # user_input(:input_right, value)
      end

      # def input_overlay(value)
      #   user_input(:input_overlay, properties)
      # end
    end
  end
end
