# frozen_string_literal: false

require_relative 'body/anti_theft'
require_relative 'body/central_locking'
require_relative 'body/doors'
require_relative 'body/memory'
require_relative 'body/windows'
require_relative 'body/windscreen'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
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
