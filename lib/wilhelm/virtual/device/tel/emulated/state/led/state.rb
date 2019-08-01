# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            module LED
              # Device::Telephone::Emulated::State::LED::State
              module State
                include Constants

                def led_red
                  state[STATE_LEDS][LED_RED]
                end

                def led_yellow
                  state[STATE_LEDS][LED_YELLOW]
                end

                def led_green
                  state[STATE_LEDS][LED_GREEN]
                end

                def red?
                  case led_red
                  when LED_OFF
                    false
                  when LED_ON
                    true
                  when LED_BLINK
                    true
                  end
                end

                def yellow?
                  case led_yellow
                  when LED_OFF
                    false
                  when LED_ON
                    true
                  when LED_BLINK
                    true
                  end
                end

                def green?
                  case led_green
                  when LED_OFF
                    false
                  when LED_ON
                    true
                  when LED_BLINK
                    true
                  end
                end

                def red_bits
                  case led_red
                  when LED_OFF
                    LED_OFF_BITS
                  when LED_ON
                    LED_ON_BITS
                  when LED_BLINK
                    LED_BLINK_BITS
                  end
                end

                def yellow_bits
                  case led_yellow
                  when LED_OFF
                    LED_OFF_BITS
                  when LED_ON
                    LED_ON_BITS
                  when LED_BLINK
                    LED_BLINK_BITS
                  end
                end

                def green_bits
                  case led_green
                  when LED_OFF
                    LED_OFF_BITS
                  when LED_ON
                    LED_ON_BITS
                  when LED_BLINK
                    LED_BLINK_BITS
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
