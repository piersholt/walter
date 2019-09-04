# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            module Display
              # RDS::Display::Menu
              module SDK
                include API
                include Constants

                def build_header(layout, indexed_items, title = nil)
                  LAYOUT_INDICES[LAYOUT_HEADER].each_with_index do |zone_index, index|
                    item = indexed_items.fetch(index, false)
                    next unless item
                    draw_row_a5(
                      layout,
                      PADDING_NONE,
                      zone_index | BLOCK,
                      item.to_s
                    )
                  end
                  return title(gfx: layout, chars: title.to_s) if title
                  render(layout)
                  true
                end

                def build_menu(layout, indexed_items)
                  LAYOUT_INDICES[layout].each_with_index do |zone_index, index|
                    item = indexed_items.fetch(index, false)
                    next unless item
                    draw_row_21(
                      layout,
                      ZERO,
                      zone_index | BLOCK | index.zero? ? FLUSH : 0,
                      item.to_s
                    )
                  end
                  render(layout)
                  true
                end
              end
            end
          end
        end
      end
    end
  end
end
