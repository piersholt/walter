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
                case command.function.value
                when FUNCTION_DIGIT
                  dial!
                  branch(LAYOUT_DIAL, FUNCTION_DIGIT, button_id(command.action))
                  dial_select(button_id(command.action))
                when FUNCTION_SOS
                  sos!
                  delegate_sos(command)
                when FUNCTION_NAVIGATE
                  delegate_navigation(command)
                when FUNCTION_INFO
                  info!
                  delegate_info(command)
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
