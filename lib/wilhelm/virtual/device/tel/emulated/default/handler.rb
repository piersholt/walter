# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Default
            # Device::Telephone::Emulated::Default::Handler
            module Handler
              include Constants

              # 0x00
              def handle_default(command)
                logger.unknown(PROC) { "#handle_default(#{command})" }
                case command.function.value
                when FUNCTION_SOS
                  sos!
                  delegate_sos(command)
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
