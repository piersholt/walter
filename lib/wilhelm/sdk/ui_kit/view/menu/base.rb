# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module View
        # SDK::UIKit::View::BaseMenu
        class BaseMenu < Base
          MENU_BASIC  = 0x60
          MENU_TITLED = 0x61
          MENU_STATIC = 0x63

          MENUS = {
            basic:  MENU_BASIC,
            titled: MENU_TITLED,
            static: MENU_STATIC
          }.freeze

          LABEL_RETURN = 'Back'

          def indexed_chars
            menu_items.map do |index, field|
              [index, field.to_c]
            end&.to_h
          end

          def indexed_items(dirty_indexes = nil)
            logger.debug(self.class) { "#indexed_items(#{dirty_indexes})" }
            return menu_items.to_h unless dirty_indexes
            menu_items.to_h.keep_if do |key, _|
              dirty_indexes.include?(key)
            end
          end

          # Helpers

          def validate(objects, max)
            LOGGER.warn(moi) { 'Too many!' } if objects.length > max
          end

          def navigation(index:, action:, label: LABEL_RETURN, properties: {})
            navigation_item = View::BaseMenuItem.new(id: :navigation, label: label, action: action, properties: properties)
            [[index, navigation_item]]
          end

          # INPUT EVENTS ------------------------------------------------------

          # Prefix of "input_" denotes hard control (not a data command.)
          def input_confirm(*)
            false
          end

          def input_left(*)
            false
          end

          def input_right(*)
            false
          end

          # Maps data request messages (0x31), to view element
          def data_select(index:, state:)
            LOGGER.debug(moi) { "#data_select(#{index}, #{state})" }
            # Non-stateful buttons for the moment
            return false unless state == :release
            # Ignore data requests for an index that doesn't exist
            return false unless indexed_items.key?(index)

            selected_item = indexed_items[index]
            changed
            notify_observers(selected_item.action, selected_item)
          end
        end
      end
    end
  end
end
