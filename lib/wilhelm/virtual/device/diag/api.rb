# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          def api_vehicle_control(from: :dia, to:, arguments:)
            try(from, to, 0x0c, arguments)
          end

          def api_service_mode_reply(from:, to:, arguments:)
            try(from, to, 0x06, arguments)
          end
        end
      end
    end
  end
end
