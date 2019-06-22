# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Comment
          module State
            include Model
            include Chainable
          end
        end
      end
    end
  end
end
