# frozen_string_literal: false

require_relative 'activate/gm'
require_relative 'activate/ft'
require_relative 'activate/bt'
require_relative 'activate/pm'
require_relative 'activate/sd'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            # ZKE Activate
            module Activate
              include GM
              include FT
              include BT
              include SD
              include PM

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
