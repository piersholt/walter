# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module API
          # Telephone::API::Status
          module Status
            include Device::API::BaseAPI
            include Constants

            # 0x2c ANZV-BOOL
            def anzv_bool_status(from: :tel, to: :anzv, **arguments)
              try(from, to, TEL_STATE, arguments)
            end

            alias status anzv_bool_status
          end
        end
      end
    end
  end
end
