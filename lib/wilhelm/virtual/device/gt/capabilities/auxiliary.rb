# frozen_string_literal: false

require_relative 'auxiliary/direct'
require_relative 'auxiliary/timer'

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # Auxiliary Ventilation Control
          module AuxiliaryVentilation
            include Direct
            include Timer

            # Aux. Status 0x15
            def auxiliary?
              obc_bool(field: 0x1b, control: 0x02)
            end
          end
        end
      end
    end
  end
end
