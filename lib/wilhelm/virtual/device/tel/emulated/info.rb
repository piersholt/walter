# frozen_string_literal: true

require_relative 'info/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Info
          module Info
            include Handler
          end
        end
      end
    end
  end
end
