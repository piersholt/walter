# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Average Speed
            module AverageSpeed
              include API
              include Constants

              # Average Speed 0x0a [Recalsulate]
              def average_speed
                obc_bool(field: FIELD_AVG_SPEED, control: CONTROL_RECALCULATE)
              end

              # Average Speed 0x0a Request draw to OBC
              def average_speed?
                obc_bool(field: FIELD_AVG_SPEED, control: CONTROL_REQUEST)
              end
            end
          end
        end
      end
    end
  end
end
