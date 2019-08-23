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
                LOGGER.unknown(MOD_PROG) { "#macro_index(#{layout}, #{function}, #{items}, #{title})" }
                LAYOUT_INDICES[layout].each do |index|
                  chars = items.shift
                  # m2 = index == INDEX_BACK | BLOCK ? FUNCTION_NAVIGATE : layout
                  d21(layout, function, index, chars)
                end
                da5(layout, 0x01, 0x00, title)
              end
            end
          end
        end
      end
    end
  end
end
