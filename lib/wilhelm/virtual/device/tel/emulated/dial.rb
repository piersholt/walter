# frozen_string_literal: true

require_relative 'dial/delegates'
require_relative 'dial/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Dial
          module Dial
            include Handler
            include Delegates
          end
        end
      end
    end
  end
end
