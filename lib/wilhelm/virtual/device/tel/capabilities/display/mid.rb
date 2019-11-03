# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Display
            # Telephone::Capabilities::Display::MID
            module MID
              include API
              include Constants

              MOD_PROG = 'Display::MID'
              LIMIT_LAYOUT = 8
              LIMIT_PAGE = 2

              def macro_mid(layout, function, items)
                LOGGER.debug(MOD_PROG) { "#macro_mid(#{layout}, #{function}, #{items})" }
                LAYOUT_INDICES[layout].each do |index|
                  d21(layout, function, index, delimiter_page(items))
                end
              end

              def delimiter_page(items)
                items.shift(LIMIT_PAGE)&.collect do |item|
                  delimiter_item(item)
                end&.flatten!
              end

              ITEM_DELIMITER = 6

              def delimiter_item(item)
                (ITEM_DELIMITER.chr << item)&.bytes
              end
            end
          end
        end
      end
    end
  end
end
