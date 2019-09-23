# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module SOS
            # Device::Telephone::Emulated::SOS::Handler
            module Handler
              include Constants

              # Function: 0x05
              def delegate_sos(command)
                layout = command.layout
                logger.unknown(PROC) { "#delegate_sos(#{layout})" }
                branch(layout.value, FUNCTION_SOS, ACTION_SOS_OPEN)
                sos_service_open
              end
            end
          end
        end
      end
    end
  end
end
