# frozen_string_literal: true

module Wilhelm
  class API
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
            # when BMBT_AUX_HEAT
            #   logger.debug(NAME) { "#handle_button(#{BMBT_AUX_HEAT})" }
            #   input_aux_heat
          when BMBT_CONFIRM
            logger.debug(NAME) { "#handle_button(#{BMBT_CONFIRM}" }
            input_confirm(state: state)
          end
        end

        private

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
end
