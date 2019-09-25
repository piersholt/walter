# frozen_string_literal: false

require_relative 'gm/anti_theft'
require_relative 'gm/central_locking'
require_relative 'gm/doors'
require_relative 'gm/memory'
require_relative 'gm/windows'
require_relative 'gm/windscreen'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GM
            include Helpers::Data
            include API
            include AntiTheft
            include CentralLocking
            include Doors
            include Memory
            include Windows
            include Windscreen

            def body_diag(byte_array)
              api_vehicle_control(to: :gm, arguments: byte_array)
            end

            def raw!(*bytes)
              body_diag(bytes)
            end

            def fetch!(constant)
              return false unless constant?(constant)
              body_diag(get_constant(constant))
            end

            private

            def constant?(constant)
              self.class.const_defined?(constant.to_sym.upcase)
            end

            def get_constant(constant)
              self.class.const_get(constant.to_sym.upcase)
            end
          end
        end
      end
    end
  end
end
