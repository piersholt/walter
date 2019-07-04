# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::MFL Events
        module MFL
          # Input related events
          module Input
            MFL_BUTTON = :button
          end

          include Input
        end
      end
    end
  end
end
