# frozen_string_literal: true

module Wilhelm
  class Virtual
    module Capabilities
      module Telephone
        # BMBT Interface Control
        module LED
          include Wilhelm::Virtual::API::Telephone
          include Constants

          def set(bit_array)
            led(leds: bit_array)
          end

          def red!
            led(leds: 0b11 << RED_SHIFT)
          end

          def yellow!
            led(leds: 0b11 << YELLOW_SHIFT)
          end

          def green!
            led(leds: 0b11 << GREEN_SHIFT)
          end

          # @deprecated
          def tel_led(value = LED_ALL)
            logger.warn { '#tel_led is deprecated!' }
            led(leds: value)
          end

          def validate_led_state(state)
            raise(ArgumentError, 'Invalid LED State') unless valid_led_state?(state)
          end

          def valid_led_state?(state)
            LED_STATES.include?(state)
          end
        end
      end
    end
  end
end
