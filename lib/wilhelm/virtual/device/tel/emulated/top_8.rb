# frozen_string_literal: true

require_relative 'top_8/actions'
require_relative 'top_8/delegates'
require_relative 'top_8/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Top8
          module Top8
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
