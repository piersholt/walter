# frozen_string_literal: true

# require '/api/base_api'

module Wilhelm
  class Virtual
    module API
      # API for command related to keys
      module Diagnostics
        include BaseAPI

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
