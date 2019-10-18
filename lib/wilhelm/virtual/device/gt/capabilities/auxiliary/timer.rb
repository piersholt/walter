# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module AuxiliaryVentilation
            # Auxiliary Ventilation Control
            module Timer
              include API
              include Constants

              # TIMER 1 -------------------------------------------------------

              # Auxiliary Timer 1 0x0f [On/Off]
              def auxiliary_timer_1(enabled = true)
                obc_bool(
                  field: FIELD_AUX_TIMER_1,
                  control: enabled ? CONTROL_ON : CONTROL_OFF
                )
              end

              alias at1 auxiliary_timer_1

              # Auxiliary Timer 1 0x0F
              def input_auxiliary_timer_1(hour = hour?, minute = min?)
                return false unless valid_time?(hour, minute)
                hour = to_twelve_hour_time(hour)
                obc_var(field: FIELD_AUX_TIMER_1, input: [hour, minute])
              end

              # TIMER 2 -------------------------------------------------------

              # Auxiliary Timer 2 0x10 [On/Off]
              def auxiliary_timer_2(enabled = true)
                obc_bool(
                  field: FIELD_AUX_TIMER_2,
                  control: enabled ? CONTROL_ON : CONTROL_OFF
                )
              end

              # Auxiliary Timer 2 0x10
              def input_auxiliary_timer_2(hour = hour?, minute = min?)
                return false unless valid_time?(hour, minute)
                hour = to_twelve_hour_time(hour)
                obc_var(field: FIELD_AUX_TIMER_2, input: [hour, minute])
              end

              alias at2 auxiliary_timer_2
            end
          end
        end
      end
    end
  end
end
