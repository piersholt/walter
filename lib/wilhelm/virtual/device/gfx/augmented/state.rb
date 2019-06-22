# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        class Augmented < Device::Augmented
          # Comment
          module State
            include Constants
            include Model
            include Chainable
            include Sent
            include Received
          end
        end
      end
    end
  end
end
