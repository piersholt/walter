# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class UserInterface
        module View
          # Manager::UserInterface::View::Index
          class Targets < SDK::UIKit::View::BasicMenu
            include SDK::UIKit::View

            NO_TARGETS = [].freeze
            NO_OPTIONS = [].freeze

            def initialize(targets)
              @targets = indexed_targets(targets)
              # @options = indexed_options(model.options)
              @options = NO_OPTIONS
            end

            def menu_items
              @targets + @options + navigation_item
            end

            private

            def navigation_item
              navigation(
                index: NAVIGATION_INDEX,
                label: 'Audio Index',
                action: :audio_index
              )
            end

            def is_selected?(targets, id)
              return false unless targets.selected_id?
              targets.selected_id == id
            end

            def indexed_targets(targets)
              return NO_TARGETS if targets.length.zero?
              validate(targets, COLUMN_ONE_MAX)

              targets.connected.first(COLUMN_ONE_MAX).map.with_index do |target, index|
                indexed_device = CheckedItem.new(
                  id: target.id,
                  checked: is_selected?(targets, target.id),
                  label: target.name,
                  action: :audio_select_target
                )
                [index, indexed_device]
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
end
