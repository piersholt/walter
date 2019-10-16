# frozen_string_literal: false

require_relative 'activate/constants'
require_relative 'activate/anti_theft'
require_relative 'activate/central_locking'
require_relative 'activate/doors'
require_relative 'activate/windows'
require_relative 'activate/windscreen'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GM
            # Diagnostics::Capabilities::GM::Activate
            module Activate
              include AntiTheft
              include CentralLocking
              include Doors
              include Windows
              include Windscreen

              # NOTE: this will conflict with other device modules
              def activate(byte_array)
                api_vehicle_control(to: :gm, arguments: byte_array)
              end

              def raw!(*bytes)
                activate(bytes)
              end

              def fetch!(constant)
                return false unless constant?(constant)
                activate(get_constant(constant))
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
end
