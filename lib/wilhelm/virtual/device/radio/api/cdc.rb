# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module API
          # CDC
          module CDC
            include Device::API::BaseAPI

            # 0x38
            def cd_changer_request(from: :rad, to: :cdc, **arguments)
              try(from, to, CDC_REQ, arguments)
            end
          end
        end
      end
    end
  end
end
