# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Range
            module Range
              include API
              include Constants

              # Range 0x06 Request Draw to OBC
              def range?
                obc_bool(field: FIELD_RANGE, control: CONTROL_REQUEST)
              end
            end
          end
        end
      end
    end
  end
end
