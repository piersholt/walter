# frozen_string_literal: true

require_relative 'diagnostics/coding'
require_relative 'diagnostics/info'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Radio::Capabilities::Diagnostics
          module Diagnostics
            include Info
            include Coding

            def error_ecu_parameter
              b0(arguments: [])
            end
          end
        end
      end
    end
  end
end
