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
          LOGGER.debug(DISPLAY_BUSY) { '#input_menu' }
          LOGGER.info(DISPLAY_BUSY) { '[MENU] pressed. Display -> Enabled.' }
          context.change_state(Enabled.new)
        end

        def monitor_off(context)
          LOGGER.debug(DISPLAY_BUSY) { '#monitor_off' }
          context.change_state(Off.new)
        end

        def kl_30(context)
          LOGGER.info(DISPLAY_BUSY) { '#kl_30' }
          context.cache.clear!
          context.change_state(Unpowered.new)
        end

        def code_on(context)
          LOGGER.info(DISPLAY_BUSY) { '#code_on' }
          context.change_state(Code.new)
        end

        def prog_off(context)
          LOGGER.info(DISPLAY_BUSY) { '#prog_off' }
          context.change_state(Enabled.new)
        end
      end
    end
  end
end
