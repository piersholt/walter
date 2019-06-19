# frozen_string_literal: true

module Wilhelm
  class Virtual
    class AugmentedRadio < AugmentedDevice
      # Radio related command constants
      module State
        module Constants
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
        end
      end
    end
  end
end
