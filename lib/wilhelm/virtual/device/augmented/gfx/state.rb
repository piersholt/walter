# frozen_string_literal: true

class Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      include Constants
      include Model
      include Chainable
      include Sent
      include Received
    end
  end
end
