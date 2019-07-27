# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # External device has priority. Do not draw/refresh display
      # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
      class Busy
        include Defaults

        DISPLAY_BUSY = 'Display (Busy)'

        def input_menu(context)
          LOGGER.debug(DISPLAY_BUSY) { "#input_menu" }
          LOGGER.info(DISPLAY_BUSY) { '[MENU] pressed. Setting Display to Enabled.'  }
          context.change_state(Enabled.new)
        end
      end
    end
  end
end
