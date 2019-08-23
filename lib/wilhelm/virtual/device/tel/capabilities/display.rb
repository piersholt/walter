# frozen_string_literal: true

require_relative 'display/detail'
require_relative 'display/index'
require_relative 'display/mid'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::SMS::Display
          module Display
            include Helpers::Display
            include Detail
            include Index
            include MID

            def d23(layout, ike, chars)
              draw_23(
                gfx: layout,
                ike: ike,
                chars: chars
              )
            end

            def d21(layout, m2, index, chars)
              draw_21(
                layout: layout,
                m2: m2,
                m3: index,
                chars: chars
              )
            end

            def da5(layout, padding, zone, chars)
              draw_a5(
                layout: layout,
                padding: padding,
                zone: zone,
                chars: chars
              )
            end

            def d24(layout, ike, chars)
              anzv_var_tel(
                field: layout,
                ike: ike,
                chars: chars
              )
            end

            # @deprecated
            def header(
              layout:,
              padding: PADDING_NONE,
              zone: INDEX_ZERO,
              chars: g_a5(layout, PADDING_NONE, INDEX_ZERO, 10)
            )
              draw_a5(
                layout: layout,
                padding: padding,
                zone: zone,
                chars: chars
              )
            end

            # @deprecated
            def render(layout, chars = STRING_BLANK)
              draw_a5(
                layout: layout,
                padding: PADDING_NONE,
                zone: INDEX_ZERO,
                chars: chars
              )
            end

            alias render_header render
            alias render_menu render
          end
        end
      end
    end
  end
end
