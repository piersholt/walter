# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < EmulatedDevice
          # Simulated CD Changer
          module Deprecated
            include Capabilities::Telephone::Constants
            # include Wilhelm::Helpers::Stateful
            include API::Telephone

            def bluetooth_pending
              LOGGER.unknown(PROC) { 'Bluetooth connection pending...' }
              tel_led(LED_YELLOW_BLINK)
            end

            def bluetooth_connecting
              LOGGER.unknown(PROC) { 'Telephone connecting...' }
              tel_led(LED_GREEN_BLINK)
            end

            def bluetooth_connected
              LOGGER.unknown(PROC) { 'Telephone connected!' }
              tel_led(LED_GREEN)
            end

            def bluetooth_disconnecting
              LOGGER.unknown(PROC) { 'Telephone disconnecting...' }
              tel_led(LED_RED_BLINK)
            end

            def bluetooth_disconnected
              LOGGER.unknown(PROC) { 'Telephone disconnected...' }
              tel_led(LED_RED)
            end
          end
        end
      end
    end
  end
end
