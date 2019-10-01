# frozen_string_literal: false

module Wilhelm
  module API
    class Display
      # Display::Defaults
      module Defaults
        # Events
        def ping(*); end

        def announce(*); end

        def monitor_on(*); end

        def monitor_off(*); end

        def obc_request(*); end

        def aux_request(*); end

        def settings_request(*); end

        def overwritten_header!(*); end

        def user_input(*); end

        def input_menu(*); end

        def input_next(*); end

        def input_prev(*); end

        def input_aux_heat(*); end

        def input_overlay(*); end

        def kl_30(*); end

        def kl_r(*); end

        def kl_15(*); end

        def code_on(*); end

        def code_off(*); end

        def prog_on(*); end

        def prog_off(*); end

        # Default Display Rendering

        def render_header(context, view)
          LOGGER.warn(self.class.name) { "#{self.class.name}#render_header" }
          case view.type
          when :default
            context.default_header = view
            context.header = view
            context.cache.write!(view.layout, context.header.indexed_chars)
          end
          true
        end

        def render_menu(context, view)
          context.menu = view
          true
        end

        def update_menu(*); end
      end
    end
  end
end
