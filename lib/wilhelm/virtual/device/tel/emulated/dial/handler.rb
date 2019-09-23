# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Dial
            # Device::Telephone::Emulated::Dial::Handler
            module Handler
              include Constants

              # 0x42
              def handle_dial(command)
                logger.unknown(PROC) { "#handle_dial(#{command})" }
                dial!
                case command.function.value
                when FUNCTION_DEFAULT
                  case command.action.value
                  when ACTION_RECENT_BACK
                    branch(LAYOUT_DIAL, FUNCTION_DEFAULT, ACTION_RECENT_BACK)
                    recent_contact
                  when ACTION_RECENT_FORWARD
                    branch(LAYOUT_DIAL, FUNCTION_DEFAULT, ACTION_RECENT_FORWARD)
                    recent_contact
                  end
                when FUNCTION_DIGIT
                  branch(LAYOUT_DIAL, FUNCTION_DIGIT, button_id(command.action))
                  dial_select(button_id(command.action))
                else
                  unknown_function(command)
                end
              end
            end
          end
        end
      end
    end
  end
end
