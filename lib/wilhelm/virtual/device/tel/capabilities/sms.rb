# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::SMS
          module SMS
            include Constants

            def messages_index(*messages)
              macro_index(LAYOUT_SMS_INDEX, FUNCTION_SMS, messages, 'SMS Index')
            end

            def messages_show(message)
              message_body = message.body.dup
              lines = []
              while message_body.length.positive?
                lines << message_body.slice!(0, 40)
              end
              macro_detail(LAYOUT_SMS_SHOW, FUNCTION_SMS, lines, message.ident)
            end
          end
        end
      end
    end
  end
end
