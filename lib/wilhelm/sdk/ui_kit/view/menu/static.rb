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
        end
      end
    end
  end
end
