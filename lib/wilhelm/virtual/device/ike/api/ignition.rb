# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Ignition
          module Ignition
            include Device::API::BaseAPI

            # 0x11 IGN
            def ignition(from: :ike, to: :glo_l, **arguments)
              dispatch_raw_command(from, to, IGNITION_REP, arguments)
            end
          end
        end
      end
    end
  end
end
