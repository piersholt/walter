# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module Settings
            # Settings: Memo
            module Memo
              include API
              include Constants

              def memo(enabled = true)
                obc_bool(
                  field: FIELD_MEMO,
                  control: enabled ? CONTROL_ON : CONTROL_OFF
                )
              end
            end
          end
        end
      end
    end
  end
end
