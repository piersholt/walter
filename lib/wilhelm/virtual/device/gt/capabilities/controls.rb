# frozen_string_literal: true

require_relative 'controls/mid'

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # GT::Capabilities::Controls
          module Controls
            include API
            include MID

            private

            def simulate_soft_input(layout, function, button)
              soft_input(
                to: :rad,
                layout: layout,
                function: function,
                button: button | STATE_PRESS
              )
              Kernel.sleep(0.05)
              soft_input(
                to: :rad,
                layout: layout,
                function: function,
                button: button | STATE_RELEASE
              )
            end
          end
        end
      end
    end
  end
end
