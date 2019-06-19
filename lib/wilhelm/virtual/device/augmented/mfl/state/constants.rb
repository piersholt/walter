# frozen_string_literal: true

module Wilhelm
  class Virtual
    class AugmentedMFL < AugmentedDevice
      # Radio related command constants
      module State
        module Constants
          MODE_RAD = :rad
          MODE_TEL = :tel

          MODE_TARGET_RAD = :rad
          MODE_TARGET_TEL = :tel

          # TODO: duplicate of Constants::Buttons
          MFL_MODE_RAD = :mfl_rt_rad
          MFL_MODE_TEL = :mfl_rt_tel

          DEFAULT_MODE = MODE_RAD
        end
      end
    end
  end
end
