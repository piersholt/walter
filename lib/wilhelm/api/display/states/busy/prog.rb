# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Busy
        # Display::Busy::Prog
        class Prog < Busy
          DISPLAY_PROG = 'Display (Prog)'

          def prog_off(context)
            LOGGER.debug(DISPLAY_PROG) { '#prog_off' }
            context.change_state(Enabled.new)
          end
        end
      end
    end
  end
end
