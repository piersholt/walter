# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          # Device::IKE::Capabilities::Ignition
          module Ignition
            include API
            include Helpers::Data

            def klr
              ignition(position: 0b0000_0001)
            end

            def kl15
              ignition(position: 0b0000_0011)
            end
          end
        end
      end
    end
  end
end
