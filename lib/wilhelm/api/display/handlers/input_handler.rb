# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Comment
      module InputHandler
        include Constants::Buttons::BMBT
        include Constants::Buttons::MFL

        NAME = 'InputHandler'

        def handle_button(button:, state:, source:)
          case button
          when BMBT_MENU
            logger.debug(NAME) { "#handle_button(#{BMBT_MENU})" }
            input_menu
          when BMBT_LEFT
            logger.debug(NAME) { "#handle_button(#{BMBT_LEFT}" }
            input_left
          when BMBT_RIGHT
            logger.debug(NAME) { "#handle_button(#{BMBT_RIGHT}" }
            input_right
          when BMBT_CONFIRM
            logger.debug(NAME) { "#handle_button(#{BMBT_CONFIRM}" }
            input_confirm(state: state)
          end
        end

        private

        def data_select(properties)
          user_input(:data_select, properties)
        end

        def input_left(value = 1)
          user_input(:input_left, value)
        end

        def input_right(value = 1)
          user_input(:input_right, value)
        end

        def input_confirm(properties)
          user_input(:input_confirm, properties)
        end
      end
    end
  end
end
