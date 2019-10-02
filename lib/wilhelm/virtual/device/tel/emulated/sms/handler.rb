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
                when FUNCTION_BACK | FUNCTION_SMS
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
                when FUNCTION_BACK | FUNCTION_SMS
                  sms_open
                when FUNCTION_BACK | FUNCTION_TELE
                  logger.warn(PROC) { "Stale layout cache! Expected ID: 0x#{(FUNCTION_BACK | FUNCTION_SMS).to_s(16)}. Actual ID: 0x#{command.function.value.to_s(16)}" }
                  sms_open
                when FUNCTION_SMS
                  logger.unknown(PROC) { 'FUNCTION_SMS' }
                when FUNCTION_TELE
                  logger.warn(PROC) { "Stale layout cache! Expected ID: 0x#{(FUNCTION_SMS).to_s(16)}. Actual ID: 0x#{command.function.value.to_s(16)}" }
                  logger.unknown(PROC) { 'FUNCTION_SMS' }
                end
              end
            end
          end
        end
      end
    end
  end
end
