# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Display
            # Telephone::Capabilities::Display::Index
            module Index
              include API
              include Constants

              MOD_PROG = 'Display::Index'

              def macro_index(layout, function, items, title = '')
                LOGGER.debug(MOD_PROG) { "#macro_index(#{layout}, #{function}, #{items}, #{title})" }
                items.each.with_index do |item, i|
                  next if item.nil?
                  index = LAYOUT_INDICES[layout].slice(i)
                  d21(layout, function, index, item)
                end
                d21(layout, FUNCTION_NAVIGATE, INDEX_BUTTON_BACK, 'Back')
                da5(layout, 0x01, 0x00, title)
              end
            end
          end
        end
      end
    end
  end
end
