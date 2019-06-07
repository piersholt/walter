# frozen_string_literal: true

class Virtual
  class AugmentedBMBT < AugmentedDevice
    module State
      # include Constants
      # include Model
      # include Chainable
      include Sent
      # include Received
    end
  end
end
