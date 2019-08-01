# frozen_string_literal: true

require_relative 'status/state'
require_relative 'status/modifiers'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Telephone::Emulated::Status
            module Status
              include State
              include Modifiers
            end
          end
        end
      end
    end
  end
end
