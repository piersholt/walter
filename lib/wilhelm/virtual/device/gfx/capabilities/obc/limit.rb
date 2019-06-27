# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface Limit
            module Limit
              include API
              include Constants

              # Speed Limit 0x09 [On, Off]
              # @param Boolean enable
              def limit(enable = true)
                obc_bool(
                  field: FIELD_LIMIT,
                  control: enable ? CONTROL_ON : CONTROL_OFF
                )
              end

              # Limit 0x09 [Set as current ppeed]
              def limit!
                obc_bool(field: FIELD_LIMIT, control: CONTROL_CURRENT_SPEED)
              end

              # Limit 0x09 Request draw OBC
              def limit?
                obc_bool(field: FIELD_LIMIT, control: CONTROL_REQUEST)
              end

              alias l limit
              alias l! limit!
              alias l? limit?

              # Speed Limit 0x09 Value (mph vs. kmph?)
              def input_limit(speed)
                obc_var(
                  b1: FIELD_LIMIT, b2: VAR_NIL,
                  b3: speed, b4: VAR_NIL
                )
              end
            end
          end
        end
      end
    end
  end
end
