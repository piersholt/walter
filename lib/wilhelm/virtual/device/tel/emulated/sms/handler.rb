# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module SMS
            # Device::Telephone::Emulated::SMS::Handler
            module Handler
              include Constants

              # 0xf0
              def handle_sms_index(command)
                logger.unknown(PROC) { "#handle_sms_index(#{command})" }
                smses!
                case command.function.value
                when FUNCTION_BACK
                  dial_open
                when FUNCTION_SMS
                  branch(command.layout.value, FUNCTION_SMS, button_id(command.action))
                  sms_select(button_id(command.action))
                end
              end

              # 0xf1
              def handle_sms_show(command)
                logger.unknown(PROC) { "#handle_sms_show(#{command})" }
                sms!
                case command.function.value
                when FUNCTION_BACK
                  sms_open
                when FUNCTION_SMS
                  false
                end
              end
            end
          end
        end
      end
    end
  end
end
