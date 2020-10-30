# frozen_string_literal: true

require_relative 'api/activate'
require_relative 'api/coding'
require_relative 'api/info'
require_relative 'api/memory'
require_relative 'api/status'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # API for command related to keys
        module API
          include Info
          include Coding
          include Memory
          include Activate
          include Status

          # 0x9f
          def api_end(from: :dia, to:, arguments: [])
            try(from, to, 0x9f, arguments)
          end
        end
      end
    end
  end
end
