# frozen_string_literal: true

require_relative 'display/generate'
require_relative 'display/header'
require_relative 'display/menu'
require_relative 'display/sdk'
require_relative 'display/quick'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            # RDS::Display
            module Display
              include Generate
              include Header
              include Menu
              include Quick
              include SDK

              def render(layout)
                draw_a5(
                  layout: layout,
                  padding: PADDING_NONE,
                  zone: NO_INDEX,
                  chars: NO_CHARS
                )
              end

              def draw_row_21(layout, m2, index, chars)
                draw_21(layout: layout, m2: m2, m3: index, chars: chars)
              end

              def draw_row_a5(layout, padding, index, chars)
                draw_a5(layout: layout, padding: padding, zone: index, chars: chars)
              end

              alias render_header render
              alias render_menu render
            end
          end
        end
      end
    end
  end
end
