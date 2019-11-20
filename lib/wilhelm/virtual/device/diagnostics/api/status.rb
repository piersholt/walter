# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Status
          module Status
            include Device::API::BaseAPI
            # 0x0b
            def api_status(from: :dia, to:, arguments: [])
              try(from, to, DIA_STATUS, arguments)
            end
          end
        end
      end
    end
  end
end
