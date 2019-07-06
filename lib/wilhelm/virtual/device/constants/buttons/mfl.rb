# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Buttons
        # Buttons::MFL
        module MFL
          # Left
          MFL_PREV     = :mfl_prev
          MFL_NEXT     = :mfl_next
          MFL_VOL_DOWN = :mfl_vol_down
          MFL_VOL_UP   = :mfl_vol_up
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
