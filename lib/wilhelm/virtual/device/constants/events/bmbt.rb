# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::BMBT Events
        module BMBT
          # Control related events
          module Control
            BMBT_CONTROL = :control
          end

          include Control
        end
      end
    end
  end
end
