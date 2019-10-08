# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        class Augmented < Device::Augmented
          module State
            # LCM::Augmented::State::Model
            module Model
              include Wilhelm::Helpers::Stateful
              include Constants

              DEFAULT_STATE = {
                backlight: BACKLIGHT_OFF
              }.freeze

              def default_state
                DEFAULT_STATE.dup
              end
            end
          end
        end
      end
    end
  end
end
