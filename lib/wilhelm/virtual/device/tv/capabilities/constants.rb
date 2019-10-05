# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TV
        module Capabilities
          # Device::TV
          module Constants
            # FIELDS
            # Settings
            FIELD_TIME            = 0x01
            FIELD_DATE            = 0x02
            # Aux. Ventilation
            FIELD_AUX_STATUS      = 0x1b

            # CONTROLS (OBC-BOOL)
            CONTROL_REQUEST       = 0x01
            CONTROL_BOOL_REQUEST  = 0x02
          end
        end
      end
    end
  end
end
