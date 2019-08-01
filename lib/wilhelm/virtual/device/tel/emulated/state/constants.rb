# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Telephone::Emulated::State::Constants
            module Constants
              STATE_STATUS = :status
              STATE_LEDS = :leds

              # LED 0x2b ---------------------------------------------------

              LED_RED    = :red
              LED_YELLOW = :yellow
              LED_GREEN  = :green

              LED_COLOURS = [LED_RED, LED_YELLOW, LED_GREEN].freeze

              LED_OFF   = :off
              LED_ON    = :on
              LED_BLINK = :blink

              LED_STATES = [LED_OFF, LED_ON, LED_BLINK].freeze

              LED_OFF_BITS   = 0b00
              LED_ON_BITS    = 0b01
              LED_BLINK_BITS = 0b11

              LED_SHIFT_RED    = 0
              LED_SHIFT_YELLOW = 2
              LED_SHIFT_GREEN  = 4

              # STATUS 0x2c  ----------------------------------------------

              STATUS_BIT_1    = :bit_1
              STATUS_BIT_2    = :bit_2
              STATUS_ACTIVE   = :active
              STATUS_POWER    = :power
              STATUS_DISPLAY  = :display
              STATUS_INCOMING = :incoming
              STATUS_MENU     = :menu
              STATUS_HFS      = :hfs

              STATUS_OFF = 0
              STATUS_ON  = 1

              STATUS_NO  = 0
              STATUS_YES = 1

              STATUS_DEFAULT = STATUS_OFF

              POWER_STATES = [STATUS_ON, STATUS_OFF].freeze

              STATUS_SHIFT_BIT_1    = 7
              STATUS_SHIFT_BIT_2    = 6
              STATUS_SHIFT_ACTIVE   = 5
              STATUS_SHIFT_POWER    = 4
              STATUS_SHIFT_DISPLAY  = 3
              STATUS_SHIFT_INCOMING = 2
              STATUS_SHIFT_MENU     = 1
              STATUS_SHIFT_HFS      = 0
            end
          end
        end
      end
    end
  end
end
