class Vehicle
  class Display
    # Display not in use, and is available
    class Available
      include Defaults
      def render_menu(context, view)
        context.menu = view
        context.bus.rad.build_menu(view.layout, view.menu_items_with_index)
        context.change_state(Captured.new)
      end

      def render_new_header(context, view)
        context.header = view
        context.bus.rad.build_new_header(view.layout, view.fields_with_index, view.title)
        context.change_state(Captured.new)
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
