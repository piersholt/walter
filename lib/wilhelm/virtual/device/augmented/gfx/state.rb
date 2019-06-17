# frozen_string_literal: true

module Wilhelm
  class Virtual
    class AugmentedGFX < AugmentedDevice
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
