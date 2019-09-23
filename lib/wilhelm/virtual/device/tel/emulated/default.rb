# frozen_string_literal: true

require_relative 'default/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Default
          module Default
            include Handler
          end
        end
      end
    end
  end
end
