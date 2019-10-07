# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Device::GFX
          module Constants
            # FIELDS
            # Settings
            FIELD_TIME            = 0x01
            FIELD_DATE            = 0x02
            FIELD_MEMO            = 0x0c
            # On-board Computer
            FIELD_TEMP            = 0x03
            FIELD_CONSUMP_1       = 0x04
            FIELD_CONSUMP_2       = 0x05
            FIELD_RANGE           = 0x06
            FIELD_DISTANCE        = 0x07
            FIELD_ARRIVAL         = 0x08
            FIELD_LIMIT           = 0x09
            FIELD_AVG_SPEED       = 0x0a
            FIELD_TIMER           = 0x0e
            FIELD_LAP_TIMER       = 0x1a
            # Code
            FIELD_CODE            = 0x0d
            # Aux. Ventilation
            FIELD_AUX_TIMER_1     = 0x0f
            FIELD_AUX_TIMER_2     = 0x10
            FIELD_AUX_HEATING_OFF = 0x11
            FIELD_AUX_HEATING_ON  = 0x12
            FIELD_AUX_VENT_OFF    = 0x13
            FIELD_AUX_VENT_ON     = 0x14

            # INPUTS (OBC-VAR)
            INPUT_LIMIT_LENGTH    = 2
            INPUT_DISTANCE_LENGTH = 2

            # CONTROLS (OBC-BOOL)
            CONTROL_NIL           = 0x00
            CONTROL_LAP           = 0x01
            CONTROL_REQUEST       = 0x01
            CONTROL_ON            = 0x04
            CONTROL_START         = 0x04
            CONTROL_OFF           = 0x08
            CONTROL_STOP          = 0x08
            CONTROL_RECALCULATE   = 0x10
            CONTROL_CURRENT_SPEED = 0x20

            # VARS
            VAR_NIL = 0x00

            # MONITOR

            # Service Mode
            BMBT_SERVICE_INFO = 0x00
            BMBT_SERVICE_KEY  = 0x0b

            # Settings: Brightness
            BMBT_BRIGHTNESS        = 0x40
            BMBT_BRIGHTNESS_FRONT  = 0x41
            BMBT_BRIGHTNESS_REAR   = 0x42

            # Via BMBT Service Mode: -10 through 10.
            # 0x80 is 0. Looks like signed magnitude?
            BRIGHTNESS_INTERVALS = [
              0xFF, 0xEC, 0xE0, 0xD4, 0xC8, 0xBC, 0xB0, 0xA4, 0x98, 0x8C,
              0x80,
              0x0C, 0x18, 0x24, 0x30, 0x3C, 0x48, 0x54, 0x60, 0x6C, 0x7F
            ].freeze

            BRIGHTNESS_RANGE = (-10..10)
          end
        end
      end
    end
  end
end
