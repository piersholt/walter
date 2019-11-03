# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # GT::Capabilities::Controls::Soft
          module Controls
            include API

            def soft_button(layout = 0x60, function = 0x00, button = 0x00)
              simulate_soft_input(layout, function, button)
            end

            private

            BUTTON_STATE_PRESS    = 0b0000_0000
            BUTTON_STATE_HOLD     = 0b0010_0000
            BUTTON_STATE_RELEASE  = 0b0100_0000

            def simulate_soft_input(layout, function, button)
              soft_input(
                to: :rad,
                layout: layout,
                function: function,
                button: button | BUTTON_STATE_PRESS
              )
              Kernel.sleep(0.05)
              soft_input(
                to: :rad,
                layout: layout,
                function: function,
                button: button | BUTTON_STATE_RELEASE
              )
            end
          end
        end
      end
    end
  end
end
