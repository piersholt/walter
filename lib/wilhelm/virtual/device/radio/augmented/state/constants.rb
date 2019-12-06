# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Augmented < Device::Augmented
          module State
            # Radio related command constants
            module Constants
              include Capabilities::UserInterface::Constants

              # Power
              ON = :on
              OFF = :off

              POWER = {
                ON => ON,
                OFF => OFF
              }.freeze

              # Source
              UNKNOWN = :unknown
              TAPE = :tape
              RADIO = :radio
              CDC = :cdc
              EXTERNAL = :external
              TV = :tv

              SOURCE = {
                TAPE => :tape,
                RADIO => :radio,
                EXTERNAL => :external,
                TV => :tv,
                CDC => :cdc
              }.freeze

              SOURCE_SEQUENCE = [RADIO, TAPE, CDC].freeze

              # Dependencies
              EMPTY_ARRAY = [].freeze
              ZERO = 0

              POWER_PRESS = 0x06
              POWER_HOLD = 0x46
              POWER_RELEASE = 0x86

              MODE_PREV_PRESS = 0x23
              MODE_PREV_HOLD = 0x63
              MODE_PREV_RELEASE = 0xA3

              MODE_NEXT_PRESS   = 0x33
              MODE_NEXT_HOLD    = 0x73
              MODE_NEXT_RELEASE = 0xB3

              MENU_PRESS   = 0x34
              MENU_HOLD    = 0x74
              MENU_RELEASE = 0xB4

              OVERLAY_PRESS = 0x30
              OVERLAY_HOLD = 0x70
              OVERLAY_RELEASE = 0xB0

              AUX_HEAT_PRESS = 0x07

              RADIO_LAYOUTS = (0x40..0x5F)
              RDS_LAYOUTS = (0x60..0x7F)
              TAPE_LAYOUTS = (0x80..0x9F)
              CDC_LAYOUTS = (0xc0..0xcF)

              RAD_LED_RESET = 0x90
              RAD_LED_OFF = 0x00
              RAD_LED_ON = 0xFF
              RAD_LED_RADIO = 0x48

              HIDE_RADIO     = 0b0000_0001
              HEADER_ONLY   = 0b0000_0010

              SOURCE_RADIO = 0x00
              SOURCE_TV = 0x01
            end
          end
        end
      end
    end
  end
end
