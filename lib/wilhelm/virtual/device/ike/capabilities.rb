# frozen_string_literal: true

require_relative 'capabilities/auxiliary'
require_relative 'capabilities/check_control'
require_relative 'capabilities/ignition'
require_relative 'capabilities/region'
require_relative 'capabilities/settings'

module Wilhelm
  module Virtual
    class Device
      module IKE
        # OBC, Set, and Aux. Vent/Heat Control
        module Capabilities
          include AuxiliaryVentilation
          include CheckControl
          include Ignition
          include Region
          include Settings

          # OBC module
          module OBC
            # must be sent to GT as otherwise IKE will overwrite
            def demo
              anzv_var(to: :gt, field: 0x06, ike: 0x00, chars: '123 KM '.bytes)
              anzv_var(to: :gt, field: 0x03, ike: 0x00, chars: '+12.3'.bytes)
              anzv_var(to: :gt, field: 0x04, ike: 0x00, chars: '12.3 L/100'.bytes)
              anzv_var(to: :gt, field: 0x05, ike: 0x00, chars: '45.6 L/100'.bytes)
              anzv_var(to: :gt, field: 0x0a, ike: 0x00, chars: '12.3 KM/H'.bytes)
              anzv_var(to: :gt, field: 0x0e, ike: 0x00, chars: '12.3  SEC '.bytes)

              # arrival updated with time, thus GT unlikely to request
              anzv_var(to: :gt, field: 0x08, ike: 0x00, chars: '12:34PM'.bytes)
              anzv_var(to: :gt, field: 0x07, ike: 0x00, chars: '1234 KM '.bytes)
              anzv_var(to: :gt, field: 0x09, ike: 0x00, chars: "123 KM/H".bytes)

              anzv_var(to: :gt, field: 0x1a, ike: 0x00, chars: '12.3  SEC '.bytes)
              anzv_var(to: :gt, field: 0x0e, ike: 0x00, chars: '43:21 MIN '.bytes)
            end
          end

          include OBC
        end
      end
    end
  end
end
