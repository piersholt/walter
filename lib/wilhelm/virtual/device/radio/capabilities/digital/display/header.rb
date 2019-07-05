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

                def generate_header(
                  layout: LAYOUT_HEADER,
                  padding: PADDING_NONE,
                  indices: HEADER_INDEXES
                )
                  indices.each do |index|
                    draw_a5(
                      layout: layout,
                      padding: padding,
                      zone: index,
                      chars: generate_a5(layout, index)
                    )
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
