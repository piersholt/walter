# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      class BaseMenu
        include Observable

        MENU_BASIC  = 0x60
        MENU_TITLED = 0x61
        MENU_STATIC = 0x63

        MENUS = { basic:  MENU_BASIC,
                  titled: MENU_TITLED,
                  static: MENU_STATIC }.freeze

        LABEL_RETURN = 'Back'

        def logger
          LogActually.wolfgang
        end

        def layout
          self.class.const_get(:LAYOUT)
        end

        def moi
          self.class.name
        end

        def menu_items_with_index
          menu_items.to_h
        end

        # Helpers

        def validate(objects, max)
          logger.warn(moi) { 'Too many!' } if objects.length > max
        end

        def navigation(index:, action:, label: LABEL_RETURN)
          navigation_item = View::BaseMenuItem.new(id: :navigation, label: label, action: action)
          [[index, navigation_item]]
        end

        # INPUT EVENTS
        # Maps data request messages (0x31), to view element

        def input_confirm(state: nil)
          false
        end

        def select_item(index:, state:)
          logger.debug(moi) { "#select_item(#{index}, #{state})" }
          # Non-stateful buttons for the moment
          return false unless state == :press
          # Ignore data requests for an index that doesn't exist
          return false unless menu_items_with_index.key?(index)

          selected_item = menu_items_with_index[index]
          changed
          notify_observers(selected_item.action, selected_item)
        end

        # Helper simulate user input
        def select(index)
          select_item(index: index, state: :press)
        end
      end
    end
  end
end
