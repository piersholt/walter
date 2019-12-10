# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # A Comment
          module RemoteControl
            NO_FUNCTION     = 0xff
            FUNCTION_LIMIT  = 12

            FUNCTION_MAP    = {
              time:         0x01,
              date:         0x02,
              consump_1:    0x04,
              consump_2:    0x05,
              range:        0x06,
              distance:     0x07,
              arrival:      0x08,
              limit:        0x09,
              avg_speed:    0x0a,
              timer:        0x0e,
              aux_timer_1:  0x0f,
              aux_timer_2:  0x10
            }.freeze

            def remote_control(*functions)
              functions&.map! { |f| FUNCTION_MAP.fetch(f, NO_FUNCTION) }
              functions&.push(NO_FUNCTION) until functions.length == FUNCTION_LIMIT
              prog(functions: functions)
            end

            alias rc remote_control
          end
        end
      end
    end
  end
end
