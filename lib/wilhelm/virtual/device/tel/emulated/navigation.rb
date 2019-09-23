# frozen_string_literal: true

require_relative 'navigation/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Navigation
          module Navigation
            include Handler
          end
        end
      end
    end
  end
end
