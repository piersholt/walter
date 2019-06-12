# frozen_string_literal: true

module Wilhelm::SDK
  class UserInterface
    module View
      # Comment
      class TitledMenu < BaseMenu
        COLUMN_ONE_MAX = 4
        COLUMN_TWO_MAX = 4

        COLUMN_ONE_OFFSET = 0
        COLUMN_TWO_OFFSET = 4

        NAVIGATION_INDEX = 7

        TITLE_OFFSET = 9
        TITLE_MAX = 2

        NO_TITLES = [].freeze

        def layout
          MENUS[:titled]
        end

        def indexed_titles(titles)
          return NO_TITLES if titles.length.zero?
          validate(titles, COLUMN_TWO_MAX)

          titles.first(TITLE_MAX).map.with_index do |option, index|
            [index + TITLE_OFFSET, option]
          end
        end
      end
    end
  end
end
