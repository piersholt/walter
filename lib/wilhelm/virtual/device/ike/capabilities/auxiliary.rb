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

            # Auxiliary Timer 1
            # @note alias at1
            def auxiliary_timer_1(enabled = true)

            end

            # Auxiliary Timer 2
            # @note alias at2
            def auxiliary_timer_2(enabled = true)

            end

            alias at1 auxiliary_timer_1
            alias at2 auxiliary_timer_2

            def auxiliary_direct(enabled = true)
              anzv_bool(control_a: x, control_b: y)
            end
          end
        end
      end
    end
  end
end
