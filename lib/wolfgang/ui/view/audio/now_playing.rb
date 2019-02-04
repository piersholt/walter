# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      module Audio
        class Index < BaseMenu
          # LAYOUT = 0x60

          NO_PLAYER = [].freeze
          NO_OPTIONS = [].freeze

          VALUES = %i[title artist album].freeze

          LAYOUT = 0x63

          def initialize(player)
            @attributes = indexed_attributes(player)
            # @options = indexed_options(model.options)
            @options = NO_OPTIONS
          end

          def menu_items
            @attributes + @options + navigation_item
          end

          private

          def navigation_item
            navigation(index: NAVIGATION_INDEX,
                       label: 'Main Menu',
                       action: :main_menu_index)
          end

          def indexed_attributes(player)
            return NO_VALUES if VALUES.length.zero?
            validate(VALUES, COLUMN_ONE_MAX)

            VALUES.first(COLUMN_ONE_MAX).map.with_index do |attribute, index|
              attribute_value = player.public_send(attribute)
              thingo = BaseMenuItem.new(label: attribute_value)
              [index, thingo]
            end
          end

          def indexed_options(options)
            return NO_OPTIONS if options.length.zero?
            validate(options, COLUMN_TWO_MAX)

            options.first(COLUMN_TWO_MAX).map.with_index do |option, index|
              [index + COLUMN_TWO_OFFSET, option]
            end
          end
        end
      end
    end
  end
end
