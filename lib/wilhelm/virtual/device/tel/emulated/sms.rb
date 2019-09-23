# frozen_string_literal: true

require_relative 'sms/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::SMS
          module SMS
            include Handler
          end
        end
      end
    end
  end
end
