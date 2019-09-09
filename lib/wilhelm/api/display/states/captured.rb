# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # In use by Walter
      class Captured
        include Defaults

        DISPLAY_CAPTURED = 'Display (Cap.)'

        def user_input(context, method, properties)
          context.logger.debug(DISPLAY_CAPTURED) { "#user_input(#{method})" }
          context.menu.public_send(method, properties)
        end

        def input_menu(context)
          LOGGER.info(DISPLAY_CAPTURED) { '#input_menu' }
          context.changed
          context.notify_observers(:destroy)
          context.change_state(Enabled.new)
        end

        def render_header(context, view)
          LOGGER.unknown(DISPLAY_CAPTURED) { '#render_header(context, view)' }
          context.default_header = view
          context.header = view

          cache = context.cache.by_layout_id(view.layout)
          cache.cache!(view.indexed_chars)
          dirty_ids = cache.dirty_ids


          LOGGER.debug(DISPLAY_CAPTURED) { 'Render header...' }
          context.bus.rad.build_header(
            view.layout,
            view.indexed_items(dirty_ids),
            view.title
          )
          true
        end

        def render_menu(context, view)
          LOGGER.debug(DISPLAY_CAPTURED) { '#render_menu(context, view)' }
          context.menu = view

          cache = context.cache.by_layout_id(view.layout)
          cache.cache!(view.indexed_chars)
          dirty_ids = cache.dirty_ids

          LOGGER.debug(DISPLAY_CAPTURED) { 'Render menu...' }
          context.bus.rad.build_menu(
            view.layout,
            view.indexed_items(dirty_ids)
          )
          true
        end
      end
    end
  end
end
