# frozen_string_literal: true

module Wilhelm
  module Services
    class Telephone
      # Telephone::Controls
      module Controls
        include Wilhelm::SDK::Controls::Register
        include Logging

        LOGGER_NAME = TEL_CONTROLS

        CONTROL_REGISTER = {
          MFL_RT_RAD        => STATELESS_CONTROL,
          MFL_RT_TEL        => STATELESS_CONTROL,

          # @note BMBT only sends volume to TEL if HFS is active
          MFL_VOL_DOWN_TEL  => STATELESS_CONTROL,
          BMBT_VOL_DOWN_TEL => STATELESS_CONTROL,

          MFL_VOL_UP_TEL    => STATELESS_CONTROL,
          BMBT_VOL_UP_TEL   => STATELESS_CONTROL,

          MFL_PREV_TEL      => STATEFUL_CONTROL,
          MFL_NEXT_TEL      => STATEFUL_CONTROL
        }.freeze

        CONTROL_ROUTES = {
          MFL_RT_RAD        => { mode_off: STATELESS },
          MFL_RT_TEL        => { mode_on: STATELESS },

          MFL_VOL_DOWN_TEL  => { volume_down: STATELESS },
          BMBT_VOL_DOWN_TEL => { volume_down: STATELESS },

          MFL_VOL_UP_TEL    => { volume_up: STATELESS },
          BMBT_VOL_UP_TEL   => { volume_up: STATELESS },

          MFL_PREV_TEL        => { backward: STATEFUL },
          MFL_NEXT_TEL        => { forward: STATEFUL }
        }.freeze
      end
    end
  end
end
