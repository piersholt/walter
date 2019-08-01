# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module API
          # Telephone::API::LED
          module LED
            include Device::API::BaseAPI
            include Constants

            # 0x2b ANZV-BOOL
            def anzv_bool_led(from: :tel, to: :anzv, **arguments)
              try(from, to, TEL_LED, arguments)
            end

            alias led anzv_bool_led
          end
        end
      end
    end
  end
end
