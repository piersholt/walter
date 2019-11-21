# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # External device has priority. Do not draw/refresh display
      # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
      class Unpowered
        include Defaults

        DISPLAY_UNPOWERED = 'Display (Unpowered)'

        def kl_r(context)
          LOGGER.debug(DISPLAY_UNPOWERED) { '#kl_r' }
          context.change_state(Unknown.new)
        end

        def kl_15(context)
          LOGGER.debug(DISPLAY_UNPOWERED) { '#kl_15' }
          context.change_state(Unknown.new)
        end
      end
    end
  end
end
