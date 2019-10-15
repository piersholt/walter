# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Activate
          module Activate
            def api_vehicle_control(from: :dia, to:, arguments:)
              try(from, to, 0x0c, arguments)
            end
          end
        end
      end
    end
  end
end
