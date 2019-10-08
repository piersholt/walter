# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::LCM Events
        module LCM
          # State related events
          module State
            BACKLIGHT_OFF = :backlight_off
            BACKLIGHT_ON  = :backlight_on

            LCM_STATES = constants.map { |i| const_get(i) }
          end

          include State
        end
      end
    end
  end
end
