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
          LogActually.ui
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

        # def indexed_chars
        #   fields.map do |field|
        #     index = field[0]
        #     field_object = field[1]
        #     [index, field_object.to_c]
        #   end&.to_h
        # end

        # Helpers

        def validate(objects, max)
          LogActually.ui.warn(moi) { 'Too many!' } if objects.length > max
        end

        def navigation(index:, action:, label: LABEL_RETURN)
          navigation_item = View::BaseMenuItem.new(id: :navigation, label: label, action: action)
          [[index, navigation_item]]
        end

        # INPUT EVENTS ------------------------------------------------------
        # Maps data request messages (0x31), to view element

        def input_confirm(state: nil)
          false
        end

        def input_next(state: nil)
          false
        end

        def input_prev(state: nil)
          false
        end

        def data_select(index:, state:)
          LogActually.ui.debug(moi) { "#data_select(#{index}, #{state})" }
          # Non-stateful buttons for the moment
          return false unless state == :release
          # Ignore data requests for an index that doesn't exist
          return false unless menu_items_with_index.key?(index)

          selected_item = menu_items_with_index[index]
          changed
          notify_observers(selected_item.action, selected_item)
        end
      end
    end
  end
end
