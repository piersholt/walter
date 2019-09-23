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

              def handle_sms_index(command)
                logger.unknown(PROC) { "#handle_sms_index(#{command})" }
                smses!
                case command.function.value
                when FUNCTION_SMS
                  generate_sms_show
                end
              end

              def handle_sms_show(command)
                logger.unknown(PROC) { "#handle_sms_show(#{command})" }
                smses!
                case command.function.value
                when FUNCTION_SMS
                  generate_sms_index
                end
              end
            end
          end
        end
      end
    end
  end
end
