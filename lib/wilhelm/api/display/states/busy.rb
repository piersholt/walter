# frozen_string_literal: true

require_relative 'busy/aux'
require_relative 'busy/code'
require_relative 'busy/dsp'
require_relative 'busy/obc'
require_relative 'busy/prog'
require_relative 'busy/settings'

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
          LOGGER.debug(DISPLAY_BUSY) { '[MENU] pressed. Display -> Enabled.' }
          context.change_state(Enabled.new)
        end

        def monitor_off(context)
          LOGGER.debug(DISPLAY_BUSY) { '#monitor_off' }
          context.change_state(Off.new)
        end

        def kl_30(context)
          LOGGER.debug(DISPLAY_BUSY) { '#kl_30' }
          LOGGER.warn(DISPLAY_BUSY) { 'Clear cache!' }
          context.cache.clear!
          context.change_state(Unpowered.new)
        end

        def code_on(context)
          LOGGER.debug(DISPLAY_BUSY) { '#code_on' }
          context.change_state(Busy::Code.new)
        end

        def prog_on(context)
          LOGGER.debug(DISPLAY_BUSY) { '#prog_on' }
          context.change_state(Busy::Prog.new)
        end
      end
    end
  end
end
