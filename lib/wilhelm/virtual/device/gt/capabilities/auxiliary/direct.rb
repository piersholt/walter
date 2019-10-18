# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module AuxiliaryVentilation
            # Auxiliary Ventilation Control
            module Direct
              include API
              include Constants

              # Auxiliary Heating 0x11, 0x12
              def auxiliary_heating(enabled = true)
                obc_bool(
                  field: enabled ? FIELD_AUX_HEATING_ON : FIELD_AUX_HEATING_OFF,
                  control: []
                )
              end

              # Auxiliary Ventilation 0x13, 0x14
              def auxiliary_ventilation(enabled = true)
                obc_bool(
                  field: enabled ? FIELD_AUX_VENT_ON : FIELD_AUX_VENT_OFF,
                  control: []
                )
              end
            end
          end
        end
      end
    end
  end
end
