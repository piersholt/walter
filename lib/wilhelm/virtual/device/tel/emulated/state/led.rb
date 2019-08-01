# frozen_string_literal: true

require_relative 'led/state'
require_relative 'led/modifiers'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Telephone::Emulated::Status
            module LED
              include State
              include Modifiers
            end
          end
        end
      end
    end
  end
end
