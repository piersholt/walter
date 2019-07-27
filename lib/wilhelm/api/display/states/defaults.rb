# frozen_string_literal: false

module Wilhelm
  module API
    class Display
      module Defaults
        def ping(*); end

        def announce(*); end

        def monitor_on(*); end

        def monitor_off(*); end

        def obc_request(*); end

        def input_menu(*); end

        def user_input(*); end

        def input_next(*); end

        def input_prev(*); end

        def overwritten!(*); end

        def input_aux_heat(*); end

        def input_overlay(*); end

        # Default Display Rendering

        def render_new_header(context, view)
          LOGGER.debug(self.class.name) { "DEFAULT #render_new_header" }
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

        def overwritten_header!(*); end
      end
    end
  end
end
