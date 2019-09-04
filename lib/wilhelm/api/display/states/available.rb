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
          # context.menu = view
          # context.bus.rad.build_menu(view.layout, view.indexed_items)
          context.render_menu(view)
        end

        def render_new_header(context, view)
          LOGGER.debug(DISPLAY_AVAILABLE) { "#render_new_header(context, view)" }
          context.change_state(Captured.new)
          context.render_new_header(view)
          # context.header = view
          # context.cache.digital.cache!(context.header.indexed_chars)
          # context.bus.rad.build_header(view.layout, view.indexed_items, view.title)
        end
      end
    end
  end
end
