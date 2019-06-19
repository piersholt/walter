# frozen_string_literal: false

module Wilhelm
  module API
    class Display
      # External device has priority. Do not draw/refresh display
      # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
      class Unknown
        include Defaults
        DISPLAY_UNKNOWN = 'Disable (Unknown)'
        def ping(context)
          LOGGER.debug(DISPLAY_UNKNOWN) { "#ping" }
          context.change_state(Enabled.new)
        end

        def announce(context)
          LOGGER.info(DISPLAY_UNKNOWN) { "#announce" }
          context.change_state(Enabled.new)
        end

        def monitor_on(context)
          LOGGER.info(DISPLAY_UNKNOWN) { "#monitor_on" }
          context.change_state(Enabled.new)
        end

        def monitor_off(context)
          LOGGER.info(DISPLAY_UNKNOWN) { "#monitor_off" }
          context.change_state(Disabled.new)
        end

        def input_menu(context)
          LOGGER.info(DISPLAY_UNKNOWN) { "#input_menu" }
          context.change_state(Enabled.new)
        end
      end
    end
  end
end
