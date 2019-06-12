class Wilhelm::API
  class Display
    # External device has priority. Do not draw/refresh display
    # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
    class Busy
      include Defaults
      DISPLAY_BUSY = 'Display (Busy)'
      def user_input(context, method, properties)
        return false
      end

      def render_menu(context, view)
        return false
      end

      def input_menu(context)
        LogActually.display.info(DISPLAY_BUSY) { "#input_menu" }
        context.change_state(Enabled.new)
      end
    end
  end
end
