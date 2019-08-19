# frozen_string_literal: true

require_relative 'display/menu'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module SMS
            # Telephone::Capabilities::SMS::Display
            module Display
              include Helpers::Display
              include Menu

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

              def draw_row_21(layout, m2, index, chars)
                draw_21(
                  layout: layout,
                  m2: m2,
                  m3: index,
                  chars: chars
                )
              end

              def draw_row_a5(layout, padding, zone, chars)
                draw_a5(
                  layout: layout,
                  padding: padding,
                  zone: zone,
                  chars: chars
                )
              end

              def draw_row_23(layout, ike, chars)
                draw_23(
                  gfx: layout,
                  ike: ike,
                  chars: chars
                )
              end

              def draw_row_24(layout, ike, chars)
                anzv_var_tel(
                  field: layout,
                  ike: ike,
                  chars: chars
                )
              end
            end
          end
        end
      end
    end
  end
end
