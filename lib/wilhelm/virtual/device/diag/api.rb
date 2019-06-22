# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # API for command related to keys
        module API
          include Device::API::BaseAPI

          def vehicle_control(from: me, to:, arguments:)
            try(from, to, 0x0C, arguments)
          end

          def service_mode_reply(from:, to:, arguments:)
            try(from, to, 0x06, arguments)
          end
        end
      end
    end
  end
end
