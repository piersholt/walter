class Vehicle
  class Display
    # External device has priority. Do not draw/refresh display
    # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
    class Enabled
      include Defaults
      DISPLAY_ENABLED = 'Display (Enabled)'

      def monitor_off(context)
        LogActually.display.info(DISPLAY_ENABLED) { "#monitor_off" }
        context.change_state(Disabled.new)
      end

      def input_aux_heat(context)
        LogActually.display.info(DISPLAY_ENABLED) { "#input_aux_heat" }
        context.render_new_header(context.header)
        context.render_menu(context.menu)
      end

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

      # def user_input(context, method, properties)
      #   return false
      # end

      # def overwritten!(context)
      #   return false
      # end

      def obc_request(context)
        LogActually.display.info(DISPLAY_ENABLED) { "#obc_request" }
        context.change_state(Busy.new)
      end
    end
  end
end
