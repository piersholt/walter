# frozen_string_literal: true

class Wilhelm::Virtual
  class SimulatedTEL < EmulatedDevice
    module State
      # Comment
      module Model
        include Wilhelm::Core::Stateful
        include Capabilities::Telephone::Constants

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

        # STATUS

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

        # LEDs

        def red_led
          state[STATE_LEDS][LED_RED]
        end

        def yellow_led
          state[STATE_LEDS][LED_YELLOW]
        end

        def green_led
          state[STATE_LEDS][LED_GREEN]
        end

        def red_bits
          case red_led
          when LED_OFF
            LED_OFF_BITS
          when LED_ON
            LED_ON_BITS
          when LED_BLINK
            LED_BLINK_BITS
          end
        end

        def yellow_bits
          case yellow_led
          when LED_OFF
            LED_OFF_BITS
          when LED_ON
            LED_ON_BITS
          when LED_BLINK
            LED_BLINK_BITS
          end
        end

        def green_bits
          case green_led
          when LED_OFF
            LED_OFF_BITS
          when LED_ON
            LED_ON_BITS
          when LED_BLINK
            LED_BLINK_BITS
          end
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
      end
    end
  end
end
