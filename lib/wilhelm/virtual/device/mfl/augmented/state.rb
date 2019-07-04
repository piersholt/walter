# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module MFL
        class Augmented < Device::Augmented
          # MFL::Augmented::State
          module State
            include Model
            include Chainable
            include Sent
          end
        end
      end
    end
  end
end
