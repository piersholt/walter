# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          # Device::IKE::Capabilities::AuxiliaryVentilation
          module AuxiliaryVentilation
            include API
            include Helpers::Data

            def auxiliary_direct(enabled = true)
              anzv_bool(b1: x, b2: y)
            end

            # Byte 1
            MEMO            = 0b0010_0000
            TIMER           = 0b0000_1000
            LIMIT           = 0b0000_0010

            # Byte 2
            AUX_TIMER_1     = 0b0000_0100
            AUX_TIMER_2     = 0b0001_0000
            AUX_HEAT        = 0b0010_0000
            AUX_VENT        = 0b0000_1000

            CODE            = 0b0100_0000

            def aux_enable
              anzv_bool(
                b1: 0x00,
                b2: AUX_HEAT | AUX_TIMER_2 | AUX_VENT | AUX_TIMER_1
              )
            end
          end
        end
      end
    end
  end
end
