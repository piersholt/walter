# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Directory
            # Device::Telephone::Emulated::Directory::Handler
            module Handler
              include Constants

              # 0x43
              def handle_directory(command)
                logger.debug(PROC) { "#handle_directory(#{command})" }
                case command.function.value
                when FUNCTION_DEFAULT
                  case command.action.value
                  when ACTION_DIRECTORY_BACK
                    branch(LAYOUT_DIRECTORY, FUNCTION_DEFAULT, ACTION_DIRECTORY_BACK)
                    directory_back
                  when ACTION_DIRECTORY_FORWARD
                    branch(LAYOUT_DIRECTORY, FUNCTION_DEFAULT, ACTION_DIRECTORY_FORWARD)
                    directory_forward
                  end
                when FUNCTION_CONTACT
                  branch(command.layout.value, FUNCTION_CONTACT, button_id(command.action))
                  directory_select(button_id(command.action))
                when FUNCTION_NAVIGATE
                  delegate_navigation(command)
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
