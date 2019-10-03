# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module PIN
            # Device::Telephone::Emulated::PIN::Handler
            module Handler
              include Constants

              # 0x05
              def handle_pin(command)
                logger.debug(PROC) { "#handle_pin(#{command})" }
                case command.function.value
                when FUNCTION_DIGIT
                  pin!
                  branch(LAYOUT_PIN, FUNCTION_DIGIT, button_id(command.action))
                  pin_service_input(button_id(command.action))
                when FUNCTION_SOS
                  delegate_sos(command)
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
