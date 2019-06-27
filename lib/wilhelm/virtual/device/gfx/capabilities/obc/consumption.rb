# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Consumption
            module Consumption
              include API
              include Constants

              # BOOLEAN

              # Consumption 1 0x04 [Recalculate]
              def consumption_1
                obc_bool(field: FIELD_CONSUMP_1, control: CONTROL_RECALCULATE)
              end

              # Consumption 2 0x05 [Recalculate]
              def consumption_2
                obc_bool(field: FIELD_CONSUMP_2, control: CONTROL_RECALCULATE)
              end

              # Consumption 1 0x04 Request Draw to OBC
              def consumption_1?
                obc_bool(field: FIELD_CONSUMP_1, control: CONTROL_REQUEST)
              end

              # Consumption 2 0x05 Request Draw to OBC
              def consumption_2?
                obc_bool(field: FIELD_CONSUMP_2, control: CONTROL_REQUEST)
              end

              alias c1! consumption_1
              alias c2! consumption_2
              alias c1? consumption_1?
              alias c2? consumption_2?
            end
          end
        end
      end
    end
  end
end
