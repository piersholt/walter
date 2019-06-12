class Wilhelm::API
  class Display
    # External device has priority. Do not draw/refresh display
    # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
    class Disabled
      include Defaults
      DISPLAY_DISABLED = 'Disable (Disabled)'
      def ping(context)
        # context.change_state(Enabled.new)
        false
      end

      def announce(context)
        LogActually.display.info(DISPLAY_DISABLED) { "#announce" }
        context.change_state(Enabled.new)
      end

      def monitor_on(context)
        LogActually.display.info(DISPLAY_DISABLED) { "#monitor_on" }
        context.change_state(Enabled.new)
      end

      def input_menu(context)
        LogActually.display.info(DISPLAY_DISABLED) { "#input_menu" }
        context.change_state(Enabled.new)
      end
    end
  end
end
