# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Code
      # When GFX is fixed on Code dislay
      class Code
        include Defaults

        DISPLAY_CODE = 'Display (Code)'

        def code_off(context)
          LOGGER.info(DISPLAY_CODE) { '#code_off' }
          context.change_state(Enabled.new)
        end
      end
    end
  end
end
