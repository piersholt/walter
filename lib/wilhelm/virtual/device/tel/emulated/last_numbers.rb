# frozen_string_literal: true

require_relative 'last_numbers/delegates'
require_relative 'last_numbers/handler'
require_relative 'last_numbers/actions'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::LastNumbers
          module LastNumbers
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
