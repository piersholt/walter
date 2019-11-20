# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Activate
          module Activate
            include Device::API::BaseAPI
            # DIA_ACTIVATE 0x0c
            def api_vehicle_control(from: :dia, to:, arguments:)
              try(from, to, DIA_ACTIVATE, arguments)
            end
          end
        end
      end
    end
  end
end
