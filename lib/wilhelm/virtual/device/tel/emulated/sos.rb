# frozen_string_literal: true

require_relative 'sos/actions'
require_relative 'sos/delegates'
require_relative 'sos/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::SOS
          module SOS
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
