# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # External device has priority. Do not draw/refresh display
      # Examples are user control, i.e. 'Set', 'Aux Heating', 'Telephone'
      class Enabled
        include Defaults

        DISPLAY_ENABLED = 'Display (Enabled)'

        def monitor_off(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#monitor_off' }
          context.change_state(Off.new)
        end

        def input_aux_heat(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#input_aux_heat' }
          context.render_header(context.header)
          context.render_menu(context.menu)
        end

        def input_overlay(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#input_overlay' }
          context.render_header(context.header)
          context.render_menu(context.menu)
        end

        def render_menu(context, view)
          LOGGER.debug(DISPLAY_ENABLED) { '#render_menu' }
          context.render_header(context.header)
          context.menu = view
          context.bus.rad.build_menu(view.layout, view.indexed_items)
          context.change_state(Captured.new)
        end

        def render_header(context, view)
          LOGGER.debug(DISPLAY_ENABLED) { '#render_header' }
          context.change_state(Captured.new)
          context.render_header(view)
        end

        def obc_request(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#obc_request' }
          context.change_state(Busy::OBC.new)
        end

        def aux_request(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#aux_request' }
          context.change_state(Busy::Aux.new)
        end

        def settings_request(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#settings_request' }
          context.change_state(Busy::Settings.new)
        end

        def kl_30(context)
          LOGGER.info(DISPLAY_ENABLED) { '#kl_30' }
          context.cache.clear!
          context.change_state(Unpowered.new)
        end

        def code_on(context)
          LOGGER.info(DISPLAY_ENABLED) { '#code_on' }
          context.change_state(Busy::Code.new)
        end

        def prog_on(context)
          LOGGER.info(DISPLAY_ENABLED) { '#prog_on' }
          context.change_state(Busy.new)
        end
      end
    end
  end
end
