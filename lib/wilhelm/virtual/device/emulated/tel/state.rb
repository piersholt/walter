# frozen_string_literal: true

module Wilhelm
  module Virtual
    class SimulatedTEL < EmulatedDevice
      # Comment
      module State
        include Model
        include Chainable
      end
    end
  end
end
