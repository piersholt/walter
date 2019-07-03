# frozen_string_literal: false

module Wilhelm
  module API
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
          LOGGER.debug(DISPLAY_BUSY) { "#input_menu" }
          LOGGER.info(DISPLAY_BUSY) { '[MENU] pressed. Setting Display to Enabled.'  }
          context.change_state(Enabled.new)
        end
      end
    end
  end
end
