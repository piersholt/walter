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
        # LOADER = ['|', '/', '-', '\\', '|', '/', '-', '\\'].freeze

        def logger
          LogActually.wolfgang
        end

        def layout
          self.class.const_get(:LAYOUT)
        end

        def select(index)
          select_item(index: index, state: :press)
        end

        def select_item(index:, state:)
          logger.debug(self.class.name) { "#input_confirm(#{index}, #{state})" }
          return false unless state == :press
          return false unless menu_items_with_index.key?(index)

          selected_item = menu_items_with_index[index]
          changed
          notify_observers(selected_item.action, selected_item)
        end

        def navigation(index:, action:, label: LABEL_RETURN)
          navigation_item = View::BaseMenuItem.new(id: :navigation, label: label, action: action)
          [[index, navigation_item]]
        end

        def menu_items_with_index
          menu_items.to_h
        end

        def validate(objects, max)
          logger.warn(self.class.name) { 'Too many!' } if objects.length > max
        end
      end
    end
  end
end
