# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Controls
        # Controls::MFL
        module MFL
          # Left
          MFL_PREV     = :mfl_prev
          MFL_NEXT     = :mfl_next
          MFL_TEL_PREV = :mfl_tel_prev
          MFL_TEL_NEXT = :mfl_tel_next
          MFL_PREV_RAD = :mfl_rad_prev
          MFL_NEXT_RAD = :mfl_rad_next

          MFL_VOL_DOWN     = :vol_down
          MFL_VOL_UP       = :vol_up
          MFL_VOL_RAD_DOWN = :vol_rad_down
          MFL_VOL_RAD_UP   = :vol_rad_up
          MFL_VOL_TEL_DOWN = :vol_tel_down
          MFL_VOL_TEL_UP   = :vol_tel_up

          MFL_TEL      = :mfl_tel

          # Right
          MFL_RT_RAD   = :mfl_rt_rad
          MFL_RT_TEL   = :mfl_rt_tel

          MFL_CONSTANTS = constants.map { |c| const_get(c) }

          def mfl?(command_argument)
            MFL_CONSTANTS.include?(command_argument)
          end
        end
      end
    end
  end
end
