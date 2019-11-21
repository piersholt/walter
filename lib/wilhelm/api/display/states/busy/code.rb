# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Busy
        # Display::Busy::Code
        class Code < Busy
          DISPLAY_CODE = 'Display (Code)'

          def code_off(context)
            LOGGER.debug(DISPLAY_CODE) { '#code_off' }
            context.change_state(Enabled.new)
          end
        end
      end
    end
  end
end
