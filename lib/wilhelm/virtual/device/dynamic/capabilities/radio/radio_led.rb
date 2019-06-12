# frozen_string_literal: true

module Wilhelm::Virtual::Capabilities
  module Radio
    # BMBT Interface Control
    module RadioLED
      include Wilhelm::Virtual::API::RadioLED
      include Constants

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
