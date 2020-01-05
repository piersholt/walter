# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Redundant
          module Redundant
            include Device::API::BaseAPI

            # 0x53 VEH_LCM_REQ
            def redundant?(from: :ike, to: :lcm, **arguments)
              dispatch_raw_command(from, to, VEH_LCM_REQ, arguments)
            end
          end
        end
      end
    end
  end
end
