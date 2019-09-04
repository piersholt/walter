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

                def build_header(layout, fields_with_index, title = nil)
                  LAYOUT_INDICES[LAYOUT_HEADER].each_with_index do |field_index, index|
                    field = fields_with_index.fetch(index, false)
                    next unless field
                    draw_row_a5(layout, PADDING_NONE, field_index, field.to_s)
                  end
                  return title(gfx: layout, chars: title.to_s) if title
                  render(layout) unless title
                  true
                end


                def build_menu(layout, menu_items_with_index)
                  LAYOUT_INDICES[layout].each_with_index do |item_index, index|
                    menu_item = menu_items_with_index.fetch(index, false)
                    next unless menu_item
                    draw_row_21(layout, ZERO, item_index, menu_item.to_s)
                    # draw_row_a5(layout, ZERO, item_index, menu_item.to_s)
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
