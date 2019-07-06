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

                def generate_menu_21(layout: LAYOUT_MENU_A,
                                     m2: ZERO,
                                     indices: LAYOUT_INDICES[layout])
                  indices.each do |index|
                    chars = generate_21(layout, m2, index, Random.rand(5..10))
                    draw_row_21(layout, m2, index, chars)
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

                def generate_row_a5(
                  layout: LAYOUT_STATIC,
                  padding: PADDING_NONE,
                  index: Random.rand(1..5),
                  chars: generate_a5(layout, padding, index, Random.rand(5..10))
                )
                  index += BLOCK
                  draw_row_a5(layout, padding, index, chars)
                  render(layout)
                end

                # def flashing(layout, padding, index, length = Random.rand(5..10))
                #   generate_a5(layout, padding, index, length)
                # end

                # def l21(input, index, m2 = 0x00)
                #   chars = input.map(&:chr).join if input.is_a?(Array)
                #   chars = input if input.is_a?(String)
                #
                #   draw_21(
                #     layout: LAYOUT_STATIC,
                #     m2: m2,
                #     m3: index,
                #     chars: chars
                #   )
                #   render(LAYOUT_STATIC)
                # end
                #
                # def la5(input, index, padding = 0x00)
                #   chars = input.map(&:chr).join if input.is_a?(Array)
                #   chars = input if input.is_a?(String)
                #
                #   draw_a5(
                #     layout: LAYOUT_STATIC,
                #     padding: padding,
                #     zone: index,
                #     chars: chars
                #   )
                #   render(LAYOUT_STATIC)
                # end
              end
            end
          end
        end
      end
    end
  end
end
