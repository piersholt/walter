# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Comment
            module Chainable
              include Constants

              # STATUS

              # Status Bit 2 In use/Active

              def inactive
                state!(STATE_STATUS => { active: NO })
                self
              end

              def active
                state!(STATE_STATUS => { active: YES })
                self
              end

              # Status Bit 3 Power

              def off
                state!(STATE_STATUS => { power: OFF })
                self
              end

              def on
                state!(STATE_STATUS => { power: ON })
                self
              end

              def power(state)
                raise(ArgumentError, 'Invalid Power State') unless POWER_STATES.include?(state)
                state!(STATE_STATUS => { power: state })
                self
              end

              # Status Bit 4 Display

              def display(state = OFF)
                state!(STATE_STATUS => { display: state })
                self
              end

              # Status Bit 5 Incoming

              def no_friends
                state!(STATE_STATUS => { incoming: NO })
                self
              end

              def incoming
                state!(STATE_STATUS => { incoming: YES })
                self
              end

              # Status Bit 6 Menu

              def menu(state = OFF)
                state!(STATE_STATUS => { menu: state })
                self
              end

              # Status Bit 7 Handsfree

              def handset
                state!(STATE_STATUS => { hfs: OFF })
                self
              end

              def handsfree
                state!(STATE_STATUS => { hfs: ON })
                self
              end

              # LEDs

              def red(state = LED_OFF)
                validate_led_state(state)
                state!(STATE_LEDS => { LED_RED => state })
                self
              end

              def yellow(state = LED_OFF)
                validate_led_state(state)
                state!(STATE_LEDS => { LED_YELLOW => state })
                self
              end

              def green(state = LED_OFF)
                validate_led_state(state)
                state!(STATE_LEDS => { LED_GREEN => state })
                self
              end

              def leds(state)
                validate_led_state(state)
                LED_COLOURS.each do |led_colour|
                  public_send(led_colour, state)
                end
                self
              end

              # API

              def status_bit_array
                i = 0
                i += 0b1 << HFS_SHIFT if hfs?
                i += 0b1 << MENU_SHIFT if menu?
                i += 0b1 << INCOMING_SHIFT if incoming?
                i += 0b1 << DISPLAY_SHIFT if display?
                i += 0b1 << POWER_SHIFT if power?
                i += 0b1 << ACTIVE_SHIFT if active?
                i
              end

              def status!
                set_status(status_bit_array)
              end

              def leds_bit_array
                i = 0
                i += red_bits if red?
                i += yellow_bits << YELLOW_SHIFT if yellow?
                i += green_bits << GREEN_SHIFT if green?
                i
              end

              def leds!
                set(leds_bit_array)
              end

              alias r red
              alias y yellow
              alias g green
            end
          end
        end
      end
    end
  end
end
