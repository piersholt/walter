# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # BMBT Interface Control
          module LED
            include API
            include Constants

            LED_OFF = 0x00
            LED_RESET = 0x90
            LED_ON = 0xff

            def led_off
              l3d(led: LED_OFF)
            end

            alias loff led_off

            def led_reset
              l3d(led: LED_RESET)
            end

            alias lreset led_reset

            def led_on
              l3d(led: LED_ON)
            end

            alias lon led_on
          end
        end
      end
    end
  end
end
