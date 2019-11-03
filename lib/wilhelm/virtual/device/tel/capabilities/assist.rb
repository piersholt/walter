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
              assist(dataset: [0x0b, 0x01, 0x80], chars: [])
            end

            # Unknown 12 00 00
            def unknown
              assist(dataset: [0x12, 0x00, 0x00], chars: [])
            end

            # Telematics 31 00 00
            def telematics?
              assist(dataset: [0x31, 0x00, 0x00], chars: [])
            end
          end
        end
      end
    end
  end
end
