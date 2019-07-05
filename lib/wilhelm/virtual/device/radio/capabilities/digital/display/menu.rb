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

                # flush
                # block
                def draw_row_21(layout, m2, index, chars)
                  draw_21(layout: layout, m2: m2, m3: index, chars: chars)
                end

                def generate_menu_21(
                  layout: LAYOUT_MENU_A,
                  m2: ZERO,
                  indices: MENU_INDEXES
                )
                  indices.each do |index|
                    chars = generate_21(layout, index)
                    draw_row_21(layout, m2, index, chars)
                  end
                  render(layout)
                  true
                end

                def generate_menu_a5(
                  layout: LAYOUT_MENU_A,
                  padding: PADDING_NONE,
                  indices: MENU_INDEXES
                )
                  indices.each do |index|
                    draw_a5(
                      layout: layout,
                      padding: padding,
                      zone: index,
                      chars: generate_a5(layout, index)
                    )
                  end
                  render(layout)
                  true
                end

                def l21(input, index, m2 = 0x00)
                  chars = input.map(&:chr).join if input.is_a?(Array)
                  chars = input if input.is_a?(String)

                  draw_21(
                    layout: LAYOUT_STATIC,
                    m2: m2,
                    m3: index,
                    chars: chars
                  )
                  render(LAYOUT_STATIC)
                end

                def la5(input, index, padding = 0x00)
                  chars = input.map(&:chr).join if input.is_a?(Array)
                  chars = input if input.is_a?(String)

                  draw_a5(
                    layout: LAYOUT_STATIC,
                    padding: padding,
                    zone: index,
                    chars: chars
                  )
                  render(LAYOUT_STATIC)
                end
              end
            end
          end
        end
      end
    end
  end
end
