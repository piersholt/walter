# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # External device has priority. Do not draw/refresh display
      # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
      class Unknown
        include Defaults

        DISPLAY_UNKNOWN = 'Disable (Unknown)'

        def ping(context)
          LOGGER.debug(DISPLAY_UNKNOWN) { '#ping' }
          context.change_state(Enabled.new)
        end

        def announce(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#announce' }
          context.change_state(Enabled.new)
        end

        def monitor_on(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#monitor_on' }
          context.change_state(Enabled.new)
        end

        def monitor_off(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#monitor_off' }
          context.change_state(Off.new)
        end

        def input_menu(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#input_menu' }
          context.change_state(Enabled.new)
        end

        def kl_30(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#kl_30' }
          context.cache.clear!
          context.change_state(Off.new)
        end

        def kl_r(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#kl_r' }
          context.change_state(Enabled.new)
        end

        def kl_15(context)
          LOGGER.info(DISPLAY_UNKNOWN) { '#kl_15' }
          context.change_state(Enabled.new)
        end
      end
    end
  end
end
