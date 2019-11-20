# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Info
          module Info
            include Device::API::BaseAPI
            # 0x00
            def api_hello(from: :dia, to:, arguments: [])
              try(from, to, DIA_HELLO, arguments)
            end
          end
        end
      end
    end
  end
end
