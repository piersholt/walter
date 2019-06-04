# frozen_string_literal: true

class Virtual
  class SimulatedTEL < EmulatedDevice
    module State
      # Comment
      module Model
        include Stateful
        include Capabilities::Telephone::Constants

        STATE_STATUS = :status
        STATE_LEDS = :leds

        DEFAULT_STATE = {
          STATE_STATUS =>
          { active: NO,
            power: OFF,
            display: DEFAULT_ZERO,
            incoming: NO,
            menu: DEFAULT_ZERO,
            hfs: NO },
          STATE_LEDS =>
          { LED_RED => LED_OFF,
            LED_YELLOW => LED_OFF,
            LED_GREEN => LED_OFF }
        }.freeze

        def default_state
          DEFAULT_STATE.dup
        end

        # STATE

        def hfs?
          case state[STATE_STATUS][:hfs]
          when 1
            true
          when 0
            false
          end
        end

        def menu?
          case state[STATE_STATUS][:menu]
          when 1
            true
          when 0
            false
          end
        end

        def incoming?
          case state[STATE_STATUS][:incoming]
          when 1
            true
          when 0
            false
          end
        end

        def display?
          case state[STATE_STATUS][:display]
          when 1
            true
          when 0
            false
          end
        end

        def power?
          case state[STATE_STATUS][:power]
          when 1
            true
          when 0
            false
          end
        end

        def active?
          case state[STATE_STATUS][:active]
          when 1
            true
          when 0
            false
          end
        end

        def red_led
          state[STATE_LEDS][LED_RED]
        end

        def yellow_led
          state[STATE_LEDS][LED_YELLOW]
        end

        def green_led
          state[STATE_LEDS][LED_GREEN]
        end

        def red?
          case red_led
          when LED_OFF
            false
          when LED_ON
            true
          when LED_BLINK
            true
          end
        end

        def yellow?
          case yellow_led
          when LED_OFF
            false
          when LED_ON
            true
          when LED_BLINK
            true
          end
        end

        def green?
          case green_led
          when LED_OFF
            false
          when LED_ON
            true
          when LED_BLINK
            true
          end
        end

        # CHAINABLE

        # Status

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
          i += 0b01 if red?
          i += 0b01 << YELLOW_SHIFT if yellow?
          i += 0b01 << GREEN_SHIFT if green?
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
