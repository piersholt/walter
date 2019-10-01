# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Busy
        # Display::Busy::DSP
        class DSP < Busy
          DISPLAY_DSP = 'Display (DSP)'

          def xxx(context)
            LOGGER.info(DISPLAY_DSP) { '#xxx' }
            context.change_state(Enabled.new)
          end
        end
      end
    end
  end
end
