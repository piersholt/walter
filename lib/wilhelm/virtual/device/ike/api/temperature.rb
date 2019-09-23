# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Temperature
          module Temperature
            include Device::API::BaseAPI

            # 0x19 TEMP_REP
            def temperature(from: :ike, to: :glo_l, **arguments)
              dispatch_raw_command(from, to, TEMP_REP, arguments)
            end

            def temperature!(ambient, coolant, unknown = 0)
              temperature(ambient: ambient, coolant: coolant, unknown: unknown)
            end

            alias temp temperature
            alias temp! temperature
          end
        end
      end
    end
  end
end
