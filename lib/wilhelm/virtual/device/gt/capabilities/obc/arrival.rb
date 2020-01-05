# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Arrival
            module Arrival
              include API
              include Constants

              # Arrival 0x08 Request draw OBC
              # @note arrival is not requested, but updated with time
              def arrival?
                obc_bool(field: FIELD_ARRIVAL, control: CONTROL_REQUEST)
              end
            end
          end
        end
      end
    end
  end
end
