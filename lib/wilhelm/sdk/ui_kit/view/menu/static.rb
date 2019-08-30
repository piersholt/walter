# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module View
        # SDK::UIKit::View::StaticMenu
        class StaticMenu < BaseMenu
          COLUMN_ONE_MAX = 5
          # COLUMN_TWO_MAX = 4

          COLUMN_ONE_OFFSET = 0
          # COLUMN_TWO_OFFSET = 5

          # NAVIGATION_INDEX = 9

          def layout
            MENUS[:static]
          end

          # @override: Base
          # Static layout does not have index 0
          def menu_items_with_index(dirty_indexes = [])
            logger.debug(self.class) { "#menu_items_with_index(#{dirty_indexes})" }
            return menu_items.to_h if dirty_indexes.empty?
            @attributes.to_h.keep_if do |key, _|
              dirty_indexes.include?(key + 1)
            end
          end

          # @override: Base
          # Static layout does not have index 0
          def indexed_chars
            menu_items.map do |index, field|
              [index + 1, field.to_c]
            end&.to_h
          end
        end
      end
    end
  end
end
