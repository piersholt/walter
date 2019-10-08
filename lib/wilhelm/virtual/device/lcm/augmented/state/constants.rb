# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        class Augmented < Device::Augmented
          module State
            # LCM::Augmented::State::Constants
            module Constants
              BACKLIGHT_OFF = 0xff

              BITMASKS = {
                # Instrument Lighting (58G)
                backlight_off: BACKLIGHT_OFF
              }.freeze
            end
          end
        end
      end
    end
  end
end
