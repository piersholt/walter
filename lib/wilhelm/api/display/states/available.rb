# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Display not in use, and is available
      class Available
        include Defaults

        DISPLAY_AVAILABLE = 'Display (Available)'

        def render_menu(context, view)
          LOGGER.debug(DISPLAY_AVAILABLE) { "#render_menu(context, view)" }
          context.change_state(Captured.new)
          context.render_menu(view)
        end

        def render_header(context, view)
          LOGGER.debug(DISPLAY_AVAILABLE) { "#render_header(context, view)" }
          context.change_state(Captured.new)
          context.render_header(view)
        end
      end
    end
  end
end
