# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Info
            # Device::Telephone::Emulated::Info::Handler
            module Handler
              include Constants

              # 0x20
              def handle_info(command)
                logger.unknown(PROC) { "#handle_info(#{command})" }
                case command.function.value
                when FUNCTION_NAVIGATE
                  delegate_navigation(command)
                else
                  unknown_function(command)
                end
              end

              # Function: 0x08
              def delegate_info(command)
                logger.unknown(PROC) { "#delegate_info" }
                case command.function.value
                when ACTION_INFO_OPEN_DIAL
                  info!
                  branch(command.layout.value, FUNCTION_INFO, ACTION_OPEN_INFO)
                  info_service_open
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
