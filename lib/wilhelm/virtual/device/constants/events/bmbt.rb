# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::BMBT Events
        module BMBT
          # Input related events
          module Input
            BMBT_BUTTON = :button
          end

          include Input
        end
      end
    end
  end
end
