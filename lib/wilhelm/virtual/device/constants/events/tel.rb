# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::Telephone Events
        module Telephone
          # Control related events
          module Control
            TELEPHONE_BUTTON = :control
          end

          include Control
        end
      end
    end
  end
end
