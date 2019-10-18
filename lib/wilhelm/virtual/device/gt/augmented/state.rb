# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        class Augmented < Device::Augmented
          # GT::Augmented::State
          module State
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
