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

# 3F 06 00 0C 00 0B 01 3F
# 3F 06 00 0C 00 07 01 33
# 3F 06 00 0C 00 04 01 30
# 3F 06 00 0C 00 47 01 73
# 3F 06 00 0C 00 46 01 72
# 3F 06 00 0C 00 45 01 71
# 3F 06 00 0C 00 44 01 70
# 3F 06 00 0C 00 03 01 37
# 3F 06 00 0C 00 45 01 71
# 3F 06 00 0C 00 44 01 70
# 3F 06 00 0C 00 47 01 73
# 3F 06 00 0C 00 46 01 72
# 3F 06 00 0C 00 03 01 37
# 3F 06 00 0C 00 04 01 30
# 3F 06 00 0C 00 00 01 34
# 3F 06 00 0C 00 01 01 35
# 3F 06 00 0C 00 10 01 24
# 3F 06 00 0C 00 10 01 24
# 3F 06 00 0C 00 10 01 24
# 3F 06 00 0C 00 11 01 25
# 3F 06 00 0C 00 12 01 26
# 3F 06 00 0C 00 13 01 27
# 3F 06 00 0C 00 0A 01 3E
# 3F 06 00 0C 00 1D 01 29
# 3F 06 00 0C 00 07 01 33
# 3F 06 00 0C 00 09 01 3D
# 3F 06 00 0C 00 08 01 3C
# 3F 06 00 0C 00 0A 01 3E
# 3F 06 00 0C 00 1D 01 29
