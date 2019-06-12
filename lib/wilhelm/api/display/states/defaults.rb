class Wilhelm::API
  class Display
    module Defaults
      def ping(context)
        false
      end

      def announce(context)
        false
      end

      def monitor_on(context)
        false
      end

      def monitor_off(context)
        false
      end

      def obc_request(context)
        false
      end

      def input_menu(context)
        false
      end

      def user_input(context, method, properties)
        false
      end

      def input_next(context, method, properties)
        false
      end

      def input_prev(context, method, properties)
        false
      end

      def overwritten!(context)
        false
      end

      def input_aux_heat(context)
        false
      end

      def input_overlay(context)
        false
      end

      # Default Display Rendering

      def render_new_header(context, view)
        LogActually.ui.debug(self.class.name) { "DEFAULT #render_new_header" }
        case view.type
        when :default
          context.default_header = view
          context.header = view
          context.cache.digital.overwrite!(context.header.indexed_chars)
        end
        true
      end

      def render_menu(context, view)
        context.menu = view
        true
      end

      def overwritten_header!(context)
        false
      end

      def overwritten!(context)
        false
      end
    end
  end
end
