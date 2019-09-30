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

          context.cache.pending!(view.layout, view.indexed_chars)
          dirty_ids = context.cache.dirty_ids(view.layout)

          return context.bus.rad.render(view.layout) if dirty_ids.empty?

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

          context.cache.pending!(view.layout, view.indexed_chars)
          dirty_ids = context.cache.dirty_ids(view.layout)
          expired = context.cache.expired?(view.layout)

          context.cache.write!(view.layout, view.indexed_chars)

          return context.bus.rad.render(view.layout) if dirty_ids.empty?

          method = expired ? :build_menu : :update_menu
          dirty_ids = nil
          method = :build_menu

          LOGGER.debug(DISPLAY_CAPTURED) { "Render menu... Method: #{method}, Dirty IDs: #{dirty_ids} (#{Thread.current})" }
          context.bus.rad.public_send(
            method,
            view.layout,
            view.indexed_items(dirty_ids)
          )
          true
        end

        def update_menu(context, view)
          LOGGER.debug(DISPLAY_CAPTURED) { '#update_menu(context, view)' }
          context.menu = view

          context.cache.pending!(view.layout, view.indexed_chars)
          dirty_ids = context.cache.dirty_ids(view.layout)
          # expired = context.cache.expired?(view.layout)

          context.cache.write!(view.layout, view.indexed_chars)

          return context.bus.rad.render(view.layout) if dirty_ids.empty?

          LOGGER.debug(DISPLAY_CAPTURED) { "Update menu... Dirty IDs: #{dirty_ids} (#{Thread.current})" }
          context.bus.rad.update_menu(
            view.layout,
            view.indexed_items(dirty_ids)
          )
          true
        end

        def kl_30(context)
          LOGGER.info(DISPLAY_CAPTURED) { '#kl_30' }
          context.cache.clear!
          context.change_state(Off.new)
        end
      end
    end
  end
end
