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
          end
        end
      end
    end
  end
end
