# frozen_string_literal: true

require_relative 'display/helpers'
require_relative 'display/header'
require_relative 'display/menu'
require_relative 'display/sdk'

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
              include SDK

              def render(layout)
                draw_a5(
                  layout:   layout,
                  pos:  PADDING_NONE,
                  zone:     NO_INDEX,
                  chars:    NO_CHARS
                )
              end

              def draw_row_21(layout, m2, index, chars)
                draw_21(
                  layout: layout,
                  m2:     m2,
                  m3:     index,
                  chars:  chars
                )
              end

              def draw_row_a5(layout, pos, index, chars)
                draw_a5(
                  layout:   layout,
                  pos:  pos,
                  zone:     index,
                  chars:    chars
                )
              end

              alias render_header render
              alias render_menu render

              def test_header(m2 = 0x01, m3 = 0x40)
                draw_21(
                  layout: SOURCE_DIGITAL | DIGITAL_HEADER,
                  m2:     m2,
                  m3:     m3,
                  chars:  Random.rand(100..999).to_s
                )
              end

              def digital_rds(
                layout: 0x60,
                m2: 0b0000_0000,
                m3: 0b0000_0000,
                chars: "FM\x05AM\x05RDS\x05SC\x05TP*\x05MODE"
              )
                draw_21(
                  to: :gt,
                  layout: layout,
                  m2: m2,
                  m3: m3,
                  chars: chars
                )
              end

            end
          end
        end
      end
    end
  end
end
