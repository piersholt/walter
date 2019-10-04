# frozen_string_literal: true

require_relative 'info/handler'
require_relative 'info/delegates'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Info
          module Info
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
