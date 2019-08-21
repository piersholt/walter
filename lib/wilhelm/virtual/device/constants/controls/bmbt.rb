# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Controls
        # Controls::BMBT
        module BMBT
          # Right Panel
          BMBT_TEL = :bmbt_tel
          BMBT_AUX_HEAT = :bmbt_aux_heat
          BMBT_NEXT = :bmbt_next
          BMBT_PREV = :bmbt_prev
          BMBT_MENU = :bmbt_menu

          # Rotary Navigation
          BMBT_LEFT = :bmbt_left
          BMBT_RIGHT = :bmbt_right
          BMBT_CONFIRM = :bmbt_confirm

          # Left Panel
          BMBT_MODE_PREV = :bmbt_mode_prev
          BMBT_MODE_NEXT = :bmbt_mode_next
          BMBT_MODE = BMBT_MODE_PREV
          BMBT_OVERLAY = :bmbt_overlay

          # Rotary Radio
          BMBT_VOL_DOWN     = :vol_down
          BMBT_VOL_UP       = :vol_up
          BMBT_VOL_RAD_DOWN = :vol_rad_down
          BMBT_VOL_RAD_UP   = :vol_rad_up
          BMBT_VOL_TEL_DOWN = :vol_tel_down
          BMBT_VOL_TEL_UP   = :vol_tel_up
          BMBT_POWER = :bmbt_power

          BMBT_CONSTANTS = constants.map { |c| const_get(c) }

          def bmbt?(command_argument)
            BMBT_CONSTANTS.include?(command_argument)
          end
        end
      end
    end
  end
end
