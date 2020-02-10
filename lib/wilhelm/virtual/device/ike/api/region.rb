# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Region
          module Region
            include Device::API::BaseAPI

            # 0x15 REGION
            def region(from: :ike, to: :glo_l, **arguments)
              dispatch_raw_command(from, to, COUNTRY_REP, arguments)
            end

            def region!(lang = 0x01, b2 = 0x04, b3 = 0x00, b4 = 0x03)
              region(lang: lang, b2: b2, b3: b3, b4: b4)
            end
          end
        end
      end
    end
  end
end
