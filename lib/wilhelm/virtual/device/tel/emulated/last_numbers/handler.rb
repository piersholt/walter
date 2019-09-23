# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module LastNumbers
            # Device::Telephone::Emulated::LastNumbers::Handler
            module Handler
              include Constants

              # "0x42"
              def handle_last_numbers(command)
                logger.unknown(PROC) { "#handle_last_numbers(#{command})" }
                dial!
                case command.function.value
                when FUNCTION_DEFAULT
                  case command.action.value
                  when ACTION_RECENT_BACK
                    branch(LAYOUT_DIAL, FUNCTION_DEFAULT, ACTION_RECENT_BACK)
                    last_numbers_back
                  when ACTION_RECENT_FORWARD
                    branch(LAYOUT_DIAL, FUNCTION_DEFAULT, ACTION_RECENT_FORWARD)
                    last_numbers_forward
                  end
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
