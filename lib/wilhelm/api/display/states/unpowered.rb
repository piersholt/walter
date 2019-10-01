# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # External device has priority. Do not draw/refresh display
      # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
      class Unpowered
        include Defaults

        DISPLAY_UNPOWERED = 'Display (Unpowered)'

        def announce(context)
          LOGGER.info(DISPLAY_UNPOWERED) { '#announce' }
          context.change_state(Enabled.new)
        end

        def kl_r(context)
          LOGGER.info(DISPLAY_UNPOWERED) { '#kl_r' }
          context.change_state(Enabled.new)
        end

        def kl_15(context)
          LOGGER.info(DISPLAY_UNPOWERED) { '#kl_15' }
          context.change_state(Enabled.new)
        end

        def code_on(context)
          LOGGER.info(DISPLAY_UNPOWERED) { '#code_on' }
          context.change_state(Code.new)
        end
      end
    end
  end
end
