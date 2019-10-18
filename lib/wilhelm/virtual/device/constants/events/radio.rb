# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::Radio Events
        module Radio
          # Control related events
          module Control
            RADIO_BUTTON = :control
          end

          # State related events
          module State
            RADIO_BODY_CLEARED = :radio_body_cleared
            PRIORITY_RADIO     = :gt_priority_radio
            PRIORITY_GT        = :gt_priority_gt
          end

          include Control
          include State
        end
      end
    end
  end
end
