# frozen_string_literal: true

require_relative 'sms/handler'
require_relative 'sms/delegates'
require_relative 'sms/actions'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::SMS
          module SMS
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
