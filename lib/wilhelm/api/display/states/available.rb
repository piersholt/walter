# frozen_string_literal: false

module Wilhelm
  module API
    class Display
      # Display not in use, and is available
      class Available
        include Defaults
        def render_menu(context, view)
          context.change_state(Captured.new)
          # context.menu = view
          # context.bus.rad.build_menu(view.layout, view.menu_items_with_index)
          context.render_menu(view)
        end

        def render_new_header(context, view)
          context.change_state(Captured.new)
          context.render_new_header(view)
          # context.header = view
          # context.cache.digital.cache!(context.header.indexed_chars)
          # context.bus.rad.build_new_header(view.layout, view.fields_with_index, view.title)
        end

        def user_input(context, method, properties)
          return false
        end

        def overwritten!(context)
          return false
        end
      end
    end
  end
end
