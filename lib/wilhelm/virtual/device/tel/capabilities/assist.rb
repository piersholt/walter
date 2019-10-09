# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::Assist
          module Assist
            include API
            include Constants

            # ANZV Icon for mail/sms
            def icon!
              icon(arguments: [0x00, 0x01])
            end

            # Status 0x0B
            def phone_status
              assist(arguments: [0x0b, 0x01, 0x80])
            end

            # Unknown 12 00 00
            def unknown
              assist(arguments: [0x12, 0x00, 0x00])
            end

            # Telematics 31 00 00
            def telematics?
              assist(arguments: [0x31, 0x00, 0x00])
            end
          end
        end
      end
    end
  end
end
