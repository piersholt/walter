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
          end
        end
      end
    end
  end
end
