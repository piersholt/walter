# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Speed
          module Speed
            include Device::API::BaseAPI

            # 0x18 SPD
            def speed(from: :ike, to: :glo_l, **arguments)
              dispatch_raw_command(from, to, SPEED, arguments)
            end

            # @param Integer speed. 2*
            # @param Integer rm. 100*
            def speed!(speed, rpm)
              sensors(speed: speed, rpm: rpm)
            end
          end
        end
      end
    end
  end
end
