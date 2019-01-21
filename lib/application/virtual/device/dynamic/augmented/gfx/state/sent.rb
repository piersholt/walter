# frozen_string_literal: true

class Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      # Comment
      module Sent
        include Events

        def evaluate_menu_gfx(command)
          case command.config.value
          when 0b0000_0001
            priority_gfx
            audio_obc_off
          when 0b0000_0011
            priority_gfx
            audio_obc_on
          end
        end
      end
    end
  end
end
