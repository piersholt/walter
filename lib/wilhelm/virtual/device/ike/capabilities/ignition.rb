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

            KLR  = 0b0000_0001
            KL15 = 0b0000_0011
            KL50 = 0b0000_0111

            def klr
              ignition(position: KLR)
            end

            def kl15
              ignition(position: KL15)
            end
          end
        end
      end
    end
  end
end
