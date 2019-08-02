# frozen_string_literal: true

require_relative 'sms/display'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::SMS
          module SMS
            include Display
            include Constants

            MOD_PROG = 'SMS'
            LIMIT_SMS = 10

            def generate_sms_index
              generate_menu_21(layout: LAYOUT_SMS_INDEX)
            end

            def generate_sms_show
              generate_menu_21(layout: LAYOUT_SMS_SHOW)
            end
          end
        end
      end
    end
  end
end
