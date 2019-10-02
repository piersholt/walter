# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Top8
            # Device::Telephone::Emulated::Top8::Handler
            module Handler
              include Constants

              # 0x80
              def handle_top_8(command)
                logger.unknown(PROC) { "#handle_top_8(#{command})" }
                case command.function.value
                when FUNCTION_NAVIGATE
                  delegate_navigation(command)
                when FUNCTION_CONTACT
                  branch(LAYOUT_TOP_8, FUNCTION_CONTACT, button_id(command.action))
                  top_8_select(button_id(command.action))
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
