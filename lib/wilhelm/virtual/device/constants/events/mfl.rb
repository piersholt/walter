# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::MFL Events
        module MFL
          # Control related events
          module Control
            MFL_BUTTON = :control
          end

          include Control
        end
      end
    end
  end
end
