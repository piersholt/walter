# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # IKE Chainable State Modifiers
            module Chainable
              include Constants
            end
          end
        end
      end
    end
  end
end
