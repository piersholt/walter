# frozen_string_literal: true

require_relative 'telematics/actions'
require_relative 'telematics/delegates'
require_relative 'telematics/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Telematics
          module Telematics
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
