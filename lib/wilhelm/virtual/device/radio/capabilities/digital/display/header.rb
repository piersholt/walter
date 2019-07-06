# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            module Display
              # RDS::Display::Header
              module Header
                include API
                include Constants

                def generate_header_a5(
                  layout: LAYOUT_HEADER,
                  padding: PADDING_NONE,
                  indices: LAYOUT_INDICES[LAYOUT_HEADER]
                )
                  indices.each do |index|
                    chars = generate_a5(layout, padding, index)
                    draw_row_a5(layout, padding, index, chars)
                  end
                  render(layout)
                end

                # BM23
                # This doesn't seem to work at all on widescreen BMBT?
                def generate_header_21(
                  layout: LAYOUT_HEADER,
                  m2: ZERO,
                  indices: LAYOUT_INDICES[LAYOUT_HEADER]
                )
                  indices.each do |index|
                    chars = generate_a5(layout, m2, index)
                    draw_row_21(layout, m2, index, chars)
                  end
                  render(layout)
                end
              end
            end
          end
        end
      end
    end
  end
end
