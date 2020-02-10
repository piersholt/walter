# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::CheckControl
          module CheckControl
            include Device::API::BaseAPI

            # 0x50 CCM-50
            def ccm_50(from: :ike, to: :ccm, arguments: [])
              dispatch_raw_command(from, to, 0x50, arguments)
            end

            # 0x52 CCM-RLY
            def ccm_relay(from: :ike, to: :ccm, **arguments)
              parse_string(arguments)
              dispatch_raw_command(from, to, CCM_RLY, arguments)
            end
          end
        end
      end
    end
  end
end
