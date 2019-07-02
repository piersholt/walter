# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Timer
            module Timer
              include API
              include Constants

              # Timer 0x0e [Start, Stop]
              def start!
                obc_bool(field: FIELD_TIMER, control: CONTROL_START)
              end

              # Timer 0x0e [Start, Stop]
              def stop!
                obc_bool(field: FIELD_TIMER, control: CONTROL_STOP)
              end

              # Timer 0x0e [Start, Stop]
              def reset!
                obc_bool(field: FIELD_TIMER, control: CONTROL_RECALCULATE)
              end

              # Timer 0x1a [Lap]
              def lap!
                obc_bool(field: FIELD_LAP_TIMER, control: CONTROL_LAP)
              end

              # Timer 0x0e Request draw to OBC
              def timer?
                obc_bool(field: FIELD_TIMER, control: CONTROL_REQUEST)
              end
            end
          end
        end
      end
    end
  end
end
