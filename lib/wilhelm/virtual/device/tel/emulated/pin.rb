# frozen_string_literal: true

require_relative 'pin/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::PIN
          module PIN
            include Handler
          end
        end
      end
    end
  end
end
