# frozen_string_literal: true

require_relative 'state/constants'
require_relative 'state/model'
require_relative 'state/status'
require_relative 'state/led'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::State
          module State
            include Model
            include Status
            include LED
          end
        end
      end
    end
  end
end
