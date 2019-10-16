# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Info
          module Info
            def api_hello(from: :dia, to:, arguments: [])
              try(from, to, 0x00, arguments)
            end
          end
        end
      end
    end
  end
end
