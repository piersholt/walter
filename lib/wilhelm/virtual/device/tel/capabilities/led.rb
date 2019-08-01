# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # BMBT Interface Control
          module LED
            include API
            include Constants

            def set(bit_array)
              led(leds: bit_array)
            end
          end
        end
      end
    end
  end
end
