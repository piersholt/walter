# frozen_string_literal: false

require_relative 'lcm/activate'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::LCM::Activate
          module LCM
            include Activate
          end
        end
      end
    end
  end
end
