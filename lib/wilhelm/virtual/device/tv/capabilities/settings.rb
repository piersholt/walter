# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module TV
        module Capabilities
          # Settings interface controls
          module Settings
            include API
            include Constants

            # Time 0x01 [Request]
            def time?
              obc_bool(field: FIELD_TIME, control: CONTROL_REQUEST)
            end

            # Date 0x02 [Request]
            def date?
              obc_bool(field: FIELD_DATE, control: CONTROL_REQUEST)
            end

            # Auxiliary Status 0x0b [0x02 Boolean Request]
            def auxiliary?
              obc_bool(field: FIELD_AUX_STATUS, control: CONTROL_BOOL_REQUEST)
            end
          end
        end
      end
    end
  end
end
