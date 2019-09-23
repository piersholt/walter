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
              end

              # Function: 0x08
              def delegate_info(command)
                logger.unknown(PROC) { "#delegate_info" }
                branch(command.layout.value, FUNCTION_INFO, ACTION_OPEN_INFO)
                info_service_open
              end
            end
          end
        end
      end
    end
  end
end
