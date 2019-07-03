# frozen_string_literal: true

module Wilhelm
  module SDK
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
              LOGGER
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

            def indexed_chars
              menu_items.map do |index, field|
                [index, field.to_c]
              end&.to_h
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

            # input: denotes button (not data) event
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
              return false unless menu_items_with_index.key?(index)

              selected_item = menu_items_with_index[index]
              changed
              notify_observers(selected_item.action, selected_item)
            end
          end
        end
      end
    end
end
