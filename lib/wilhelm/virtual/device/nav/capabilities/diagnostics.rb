# frozen_string_literal: true

require_relative 'diagnostics/info'

module Wilhelm
  module Virtual
    class Device
      module Navigation
        module Capabilities
          # Navigation::Capabilities::Diagnostics
          module Diagnostics
            include Info
          end
        end
      end
    end
  end
end
