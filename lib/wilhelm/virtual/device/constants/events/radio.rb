# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::Radio Events
        module Radio
          # State related events
          module State
            RADIO_BODY_CLEARED = :radio_body_cleared
            PRIORITY_RADIO     = :gfx_priority_radio
            PRIORITY_GFX       = :gfx_priority_gfx
          end

          include State
        end
      end
    end
  end
end
