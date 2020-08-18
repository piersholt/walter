# frozen_string_literal: false

require_relative 'lcm/activate'
require_relative 'lcm/coding'
require_relative 'lcm/memory'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::LCM::Activate
          module LCM
            include Activate
            include Coding
            include Memory

            def lcm_status
              api_status(from: :dia, to: :lcm, arguments: [])
            end
          end
        end
      end
    end
  end
end
