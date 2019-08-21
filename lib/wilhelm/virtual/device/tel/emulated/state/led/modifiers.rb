# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            module LED
              # Device::Telephone::Emulated::State::LED::Modifiers
              module Modifiers
                include Constants

                # RED ---------------------------------------------------------

                def red(state = LED_OFF)
                  validate_led_state(state)
                  state!(STATE_LEDS => { LED_RED => state })
                  self
                end

                alias r red

                # YELLOW ------------------------------------------------------

                def yellow(state = LED_OFF)
                  validate_led_state(state)
                  state!(STATE_LEDS => { LED_YELLOW => state })
                  self
                end

                alias y yellow

                # GREEN -------------------------------------------------------

                def green(state = LED_OFF)
                  validate_led_state(state)
                  state!(STATE_LEDS => { LED_GREEN => state })
                  self
                end

                alias g green

                # API ---------------------------------------------------------

                def leds(state)
                  validate_led_state(state)
                  LED_COLOURS.each do |led_colour|
                    public_send(led_colour, state)
                  end
                  self
                end

                def validate_led_state(state)
                  raise(ArgumentError, 'Invalid LED State') unless valid_led_state?(state)
                end

                def valid_led_state?(state)
                  LED_STATES.include?(state)
                end

                def leds!
                  set(leds_bit_field)
                end
              end
            end
          end
        end
      end
    end
  end
end
