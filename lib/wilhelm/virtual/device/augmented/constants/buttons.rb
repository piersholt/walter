# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Buttons
        module BMBT
          BMBT_LEFT = :bmbt_left
          BMBT_RIGHT = :bmbt_right
          BMBT_CONFIRM = :bmbt_confirm
          BMBT_MENU = :bmbt_menu

          BMBT_AUX_HEAT = :bmbt_aux_heat

          BMBT_TEL = :bmbt_tel

          BMBT_MODE = :bmbt_mode
          BMBT_OVERLAY = :bmbt_overlay
          BMBT_POWER = :bmbt_power
          BMBT_NEXT = :bmbt_next
          BMBT_PREV = :bmbt_prev
          BMBT_VOL_DOWN = :bmbt_vol_down
          BMBT_VOL_UP   = :bmbt_vol_up

          BMBT_PLAYBACK = [BMBT_POWER, BMBT_NEXT, BMBT_PREV].freeze
          BMBT_ALL = [BMBT_MODE, BMBT_TEL, BMBT_MENU, BMBT_AUX_HEAT, BMBT_CONFIRM, BMBT_NEXT, BMBT_PREV, BMBT_LEFT, BMBT_RIGHT].freeze

          def bmbt?(command_argument)
            BMBT_ALL.include?(command_argument)
          end
        end

        module MFL
          MFL_NEXT     = :mfl_next
          MFL_PREV     = :mfl_prev
          MFL_VOL_DOWN = :mfl_vol_down
          MFL_VOL_UP   = :mfl_vol_up

          MFL_TEL      = :mfl_tel
          MFL_RT_RAD   = :mfl_rt_rad
          MFL_RT_TEL   = :mfl_rt_tel

          MFL_PLAYBACK = [MFL_NEXT, MFL_PREV, MFL_VOL_DOWN, MFL_VOL_UP].freeze
          MFL_ALL = [MFL_NEXT, MFL_PREV, MFL_VOL_DOWN, MFL_VOL_UP, MFL_TEL, MFL_RT_RAD, MFL_RT_TEL].freeze

          def mfl?(command_argument)
            MFL_ALL.include?(command_argument)
          end
        end
      end
    end
  end
end
