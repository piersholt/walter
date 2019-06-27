# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Auxiliary Ventilation Control
          module AuxiliaryVentilation
            include API
            include Constants

            # Auxiliary Timer 1 0x0f [On/Off]
            # @note alias at1
            def auxiliary_timer_1(enabled = true)
              obc_bool(
                field: FIELD_AUX_TIMER_1,
                control: enabled ? CONTROL_ON : CONTROL_OFF
              )
            end

            # Auxiliary Timer 2 0x10 [On/Off]
            # @note alias at2
            def auxiliary_timer_2(enabled = true)
              obc_bool(
                field: FIELD_AUX_TIMER_2,
                control: enabled ? CONTROL_ON : CONTROL_OFF
              )
            end

            alias at1 auxiliary_timer_1
            alias at2 auxiliary_timer_2
          end
        end
      end
    end
  end
end
