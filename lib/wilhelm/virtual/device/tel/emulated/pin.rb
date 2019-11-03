# frozen_string_literal: true

require_relative 'pin/handler'
require_relative 'pin/delegates'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::PIN
          module PIN
            include Handler
            include Delegates
          end
        end
      end
    end
  end
end
