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

          # @note this would replace #overwrite at Display::Listener
          # LOGGER.debug(DISPLAY_CAPTURED) { 'Overwrite cache with view field values...' }
          # context.cache.digital.overwrite!(context.header.indexed_chars)

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
          # return false if dirty_ids.empty?

          LOGGER.debug(DISPLAY_CAPTURED) { 'Render menu...' }
          context.bus.rad.build_menu(
            view.layout,
            view.indexed_items(dirty_ids)
          )
          true
        end

        def overwritten_header!(context)
          context.logger.warn(DISPLAY_CAPTURED) { '#overwritten_header!(context)' }
          dirty_ids = context.cache.digital.dirty_ids
          context.logger.warn(DISPLAY_CAPTURED) { "dirty_ids => #{dirty_ids}" }
          context.render_header(context.header) unless dirty_ids.empty?
        end

        def overwritten!(context)
          context.logger.warn(DISPLAY_CAPTURED) { '#overwritten!(context)' }
          context.bus.rad.render(context.menu.layout)
        end
      end
    end
  end
end
