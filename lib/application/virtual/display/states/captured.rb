class Virtual
  class Display
    # In use by Walter
    class Captured

      def user_input(context, method, properties)
        context.logger.debug(self.class) { "#user_input(#{method})" }
        context.menu.public_send(method, properties)
      end

      def render_header(context, view)
        # context.header = view
        # context.bus.rad.build_header(view.layout, view.fields_with_index, view.title)
        # context.change_state(Captured.new)
      end

      def render_new_header(context, view)
        case view.type
        when :default
          context.default_header = view
          context.header = view
        when :notification
          context.notification_header = view
          context.header = view
          Thread.new(context, view) do |contextual, vuew|
            begin
              Kernel.sleep(contextual.timeout)
              result = contextual.dismiss(vuew)
              LogActually.display.debug(self.class.name) { "Dimiss? => #{result}" }
            rescue StandardError => e
              LogActually.display.error(self.class.name) { e }
            end
            LogActually.display.warn(self.class.name) { 'Notify dismiss thread ending?' } unless result
          end
        end
        context.bus.rad.build_new_header(view.layout, view.fields_with_index, view.title)
        # context.change_state(Captured.new)
      end

      def dismiss(context, view)
        return false unless context.notification_header == view
        context.render_new_header(context.default_header)
        context.header = context.default_header
        context.notification_header = nil
        true
      end

      def render_menu(context, view)
        context.menu = view
        context.bus.rad.build_menu(view.layout, view.menu_items_with_index)
        # context.change_state(Captured.new)
        true
      end

      def overwritten!(context)
        context.logger.warn(self.class) { "#overwritten!()" }
        context.bus.rad.render(context.menu.layout)
        context.bus.rad.render(context.header.layout)
      end
    end
  end
end
