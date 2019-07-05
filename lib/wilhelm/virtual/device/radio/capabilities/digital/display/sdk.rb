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

                def build_menu(layout, menu_items_with_index)
                  LAYOUT_INDICES[layout].each_with_index do |item_index, index|
                    menu_item = menu_items_with_index.fetch(index, false)
                    next unless menu_item
                    draw_21(
                      layout: layout,
                      m2: Random.rand(0x00..0x0F),
                      m3: item_index,
                      chars: menu_item.to_s
                    )
                  end
                  render(layout)
                  true
                end

                # def build_legacy_header(layout, fields_with_index, title = nil)
                #   FIELD_INDEXES.each_with_index do |field_index, index|
                #     field = fields_with_index.fetch(index, false)
                #     next unless field
                #     draw_21(
                #       layout: layout,
                #       m2: ZERO,
                #       m3: field_index,
                #       chars: field.to_s
                #     )
                #   end
                #   return title(gfx: layout, chars: title) if title
                #   render_header(layout) unless title
                #   true
                # end

                def build_header(layout, fields_with_index, title = nil)
                  LAYOUT_INDICES[LAYOUT_HEADER].each_with_index do |field_index, index|
                    field = fields_with_index.fetch(index, false)
                    next unless field
                    draw_a5(
                      layout: layout,
                      padding: PADDING_NONE,
                      zone: field_index,
                      chars: field.to_s
                    )
                  end
                  return title(gfx: layout, chars: title.to_s) if title
                  render(layout) unless title
                  true
                end

                alias build_new_header build_header
              end
            end
          end
        end
      end
    end
  end
end
