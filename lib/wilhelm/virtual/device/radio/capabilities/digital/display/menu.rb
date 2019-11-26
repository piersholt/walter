# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            module Display
              # RDS::Display::Menu
              module Menu
                include API
                include Constants
                include Wilhelm::Helpers::DataTools
                include Helpers::Data

                def generate_menu_21(
                  layout: LAYOUT_MENU_A,
                  m2: ZERO,
                  indices: LAYOUT_INDICES[layout]
                )
                  indices.each_with_index do |zone_index, index|
                    chars = generate_21(layout, m2, zone_index, Random.rand(5..10))
                    draw_row_21(
                      layout,
                      m2,
                      zone_index | BLOCK | (index.zero? ? FLUSH : 0)
                      chars
                    )
                  end
                  render(layout)
                  true
                end

                # This does not work for 0x60, or 0x61.
                # Neither recognises index 0- presumeably as
                # index 0 is title in 0x62 which is written by
                # 0x23...
                def generate_menu_a5(
                  layout: LAYOUT_MENU_A,
                  padding: PADDING_NONE,
                  indices: LAYOUT_INDICES[layout]
                )
                  indices.each do |index|
                    chars = generate_a5(layout, padding, index, Random.rand(5..10))
                    draw_row_a5(layout, padding, index, chars)
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
