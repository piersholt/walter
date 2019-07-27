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
          context.change_state(Disabled.new)
        end

        def input_aux_heat(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#input_aux_heat' }
          context.render_new_header(context.header)
          context.render_menu(context.menu)
        end

        def input_overlay(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#input_overlay' }
          context.render_new_header(context.header)
          context.render_menu(context.menu)
        end

        def render_menu(context, view)
          LOGGER.debug(DISPLAY_ENABLED) { '#render_menu' }
          context.render_new_header(context.header)
          context.menu = view
          context.bus.rad.build_menu(view.layout, view.menu_items_with_index)
          context.change_state(Captured.new)
        end

        def render_new_header(context, view)
          LOGGER.debug(DISPLAY_ENABLED) { '#render_new_header' }
          context.change_state(Captured.new)
          context.render_new_header(view)
          # context.header = view
          # dirty_ids = context.cache.digital.dirty_ids
          # LOGGER.debug(DISPLAY_CAPTURED) { "Get dirty field IDs => #{dirty_ids}" }

          # LOGGER.debug(DISPLAY_CAPTURED) { "Overwrite cache with view field values..." }
          # context.cache.digital.overwrite!(context.header.indexed_chars)

          # LOGGER.debug(DISPLAY_CAPTURED) { "Render header..." }
          # context.bus.rad.build_new_header(view.layout, view.fields_with_index, view.title)
        end

        def obc_request(context)
          LOGGER.debug(DISPLAY_ENABLED) { '#obc_request' }
          context.change_state(Busy.new)
        end
      end
    end
  end
end
