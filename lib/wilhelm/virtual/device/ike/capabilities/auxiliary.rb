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
              anzv_bool(control_a: x, control_b: y)
            end
          end
        end
      end
    end
  end
end
