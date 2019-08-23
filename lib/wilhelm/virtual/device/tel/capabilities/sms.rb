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
              macro_index(LAYOUT_SMS_INDEX, 0xf0, messages, 'SMS Index')
            end

            def message_detail(message)

            end
          end
        end
      end
    end
  end
end
