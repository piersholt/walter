# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Navigation
            # Device::Telephone::Emulated::Navigation::Handler
            module Handler
              include Constants

              # Function: 0x07
              def delegate_navigation(command)
                logger.debug(PROC) { "#delegate_navigation(#{command.layout.ugly}, #{command.pretty})" }
                case button_id(command.action)
                when ACTION_SMS_OPEN_DIAL
                  branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_SMS_OPEN_DIAL)
                  dial!
                  dial_open
                when ACTION_OPEN_DIAL
                  branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIAL)
                  dial!
                  dial_open
                when ACTION_OPEN_SMS
                  branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_SMS)
                  sms_index!
                  sms_open
                when ACTION_OPEN_DIR
                  branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIR)
                  directory!
                  directory_open
                end
              end
            end
          end
        end
      end
    end
  end
end
