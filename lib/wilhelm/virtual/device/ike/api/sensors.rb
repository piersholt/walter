# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Sensors
          module Sensors
            include Device::API::BaseAPI

            # 0x13 SEN
            def sensors(from: :ike, to: :glo_l, **arguments)
              dispatch_raw_command(from, to, SENSORS_REP, arguments)
            end

            def sensors!(s1 = 0x00, s2 = 0x00, s3 = 0x00)
              sensors(s1: s1, s2: s2, s3: s3)
            end
          end
        end
      end
    end
  end
end
