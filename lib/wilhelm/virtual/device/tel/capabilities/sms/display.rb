# frozen_string_literal: true

require_relative 'display/generate'
require_relative 'display/menu'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module SMS
            # Telephone::Capabilities::SMS::Display
            module Display
              include Generate
              include Menu

              def render(layout, chars = nil)
                LOGGER.unknown('SMS') { "#render(#{layout}, #{chars})" }
                chars = generate_a5(layout, PADDING_NONE, INDEX_ZERO, Random.rand(5..10)) unless chars
                draw_a5(
                  layout: layout,
                  padding: PADDING_NONE,
                  zone: INDEX_ZERO,
                  chars: chars.map(&:chr).join
                )
              end

              def draw_row_21(layout, m2, index, chars)
                draw_21(layout: layout, m2: m2, m3: index, chars: chars)
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
