# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Display
            # Telephone::Capabilities::Display::Detail
            module Detail
              include API
              include Constants

              MOD_PROG = 'Display::Detail'

              def macro_detail(layout, function, lines, title = '')
                LOGGER.unknown(MOD_PROG) { "#macro_detail(#{layout}, #{function}, #{lines}, #{title})" }
                lines.each.with_index do |item, i|
                  index = LAYOUT_INDICES[layout].slice(i)
                  d21(layout, function, index, item)
                end
                d21(layout, FUNCTION_BACK, INDEX_BUTTON_BACK, 'Back')
                # d21(layout, FUNCTION_BACK, INDEX_BUTTON_LEFT, 'Left')
                # d21(layout, FUNCTION_BACK, INDEX_BUTTON_RIGHT, 'Right')
                # d21(layout, FUNCTION_BACK, INDEX_BUTTON_CENTRE, 'Centre')
                da5(layout, 0x01, 0x00, title)
              end
            end
          end
        end
      end
    end
  end
end
