# frozen_string_literal: true

class Virtual
  class AugmentedBMBT < AugmentedDevice
    module State
      # Comment
      module Sent
        include Events

        MENU_RELEASE = 0xB4
        AUX_HEAT_RELEASE = 0x87
        CONFIRM_HOLD = 0x45
        CONFIRM_RELEASE = 0x85

        def handle_bmbt_1_button(command)
          value = command.totally_unique_variable_name

          case value
          when MENU_RELEASE
            logger.debug(moi) { "BMBT 1 -> Menu Release" }
            changed
            notify_observers(INPUT_MENU, source: ident)
          when CONFIRM_HOLD
            logger.debug(moi) { "BMBT 1 -> Confirm Hold" }
            state_value = command.totally_unique_variable_name
            logger.unknown(moi) { "button => #{state_value}"}
            button_state =
              case state_value
              when 0x05
                :press
              when 0x45
                :hold
              when 0x85
                :release
              end
            changed
            notify_observers(INPUT_CONFIRM, state: button_state)
          when AUX_HEAT_RELEASE
            logger.debug(moi) { "BMBT 1 -> Menu Release" }
            changed
            notify_observers(INPUT_AUX_HEAT, source: ident)
          end
        end
      end
    end
  end
end
