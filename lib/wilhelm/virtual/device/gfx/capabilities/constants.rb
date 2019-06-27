# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Comment
          module Constants
            # FIELDS
            # Settings
            FIELD_TIME     = 0x01
            FIELD_DATE     = 0x02
            FIELD_MEMO     = 0x0c
            # On-board Computer
            FIELD_TEMP      = 0x03
            FIELD_CONSUMP_1 = 0x04
            FIELD_CONSUMP_2 = 0x05
            FIELD_RANGE     = 0x06
            FIELD_DISTANCE  = 0x07
            FIELD_ARRIVAL   = 0x08
            FIELD_LIMIT     = 0x09
            FIELD_AVG_SPEED = 0x0a
            FIELD_TIMER     = 0x0e
            FIELD_LAP_TIMER = 0x1a
            # Code
            FIELD_CODE = 0x0d
            # Aux. Ventilation
            FIELD_AUX_TIMER_1  = 0x0f
            FIELD_AUX_TIMER_2  = 0x10

            # CONTROLS
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
          end
        end
      end
    end
  end
end
