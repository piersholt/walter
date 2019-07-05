# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDSDisplay
            # RDSDisplay::Menu
            module Menu
              include API
              include Constants
              include Wilhelm::Helpers::DataTools

              def render_menu(layout:)
                draw_a5(
                  layout: layout,
                  padding: PADDING_NONE,
                  zone: NO_INDEX,
                  chars: NO_CHARS
                )
              end

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
                render_menu(layout: layout)
                true
              end

              # the layout must match
              def generate_menu(layout: LAYOUT_MENU_A, indices: ITEM_INDEXES)
                indices.each do |index|
                  draw_21(
                    layout: layout,
                    m2: ZERO,
                    m3: index,
                    chars: generate_21(layout, index)
                  )
                end
                render_menu(layout: layout)
                true
              end

              # the layout must match
              def menu(layout: LAYOUT_MENU_A, padding: PADDING_NONE, indices: ITEM_INDEXES)
                indices.each do |index|
                  draw_a5(
                    layout: layout,
                    padding: padding,
                    zone: index,
                    chars: generate_a5(layout, index)
                  )
                end
                true
              end
            end
          end
        end
      end
    end
  end
end
