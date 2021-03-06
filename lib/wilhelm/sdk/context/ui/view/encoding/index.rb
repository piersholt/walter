# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module View
          module Encoding
            # Context::UserInterface::View::Characters::Index
            class Index < UIKit::View::TitledMenu
              include UIKit::View
              include Constants

              def initialize(characters)
                @options = indexed_options(characters)
                @titles = indexed_titles(titles)
              end

              def titles
                [BaseMenuItem.new(label: 'Characters')]
              end

              def menu_items
                @options + @titles + navigation_item
              end

              def navigation_item
                navigation(
                  index: NAVIGATION_INDEX,
                  label: 'Context Menu',
                  action: :context_index
                )
              end

              private

              def indexed_options(options)
                options.first(COLUMN_ONE_MAX).map.with_index do |option, index|
                  indexed_option =
                    BaseMenuItem.new(label: option[:label],
                                     action: option[:action])
                  [index, indexed_option]
                end
              end
            end
          end
        end
      end
    end
  end
end
