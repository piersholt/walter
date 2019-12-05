# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Augmented < Device::Augmented
          # Device::Radio::Augmented
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
