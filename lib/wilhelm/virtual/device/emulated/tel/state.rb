# frozen_string_literal: true

class Wilhelm::Virtual
  class SimulatedTEL < EmulatedDevice
    # Comment
    module State
      include Model
      include Chainable
    end
  end
end
