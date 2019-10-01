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
                LAYOUT_INDICES[layout].each do |index|
                  chars = lines.shift
                  next unless chars
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
