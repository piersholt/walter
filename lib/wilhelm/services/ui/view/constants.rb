# frozen_string_literal: false

module Wilhelm
  module Services
    class UserInterface
      module View
        # Walter constants
        module Constants
          BASIC_MENU      = Wilhelm::SDK::UserInterface::View::BasicMenu
          TITLED_MENU     = Wilhelm::SDK::UserInterface::View::TitledMenu
          STATIC_MENU     = Wilhelm::SDK::UserInterface::View::StaticMenu

          CHECKED_ITEM    = Wilhelm::SDK::UserInterface::View::CheckedItem
          BASE_MENU_ITEM    = Wilhelm::SDK::UserInterface::View::BaseMenuItem
        end

        # Comment
        module Header
          DEFAULT_HEADER  = Wilhelm::SDK::UserInterface::View::BaseHeader
        end

        # Comment
        module Manager
          include Constants

          class Index < BASIC_MENU
            include Constants
          end

          class Device < BASIC_MENU
            include Constants
          end
        end

        # Comment
        module Audio
          include Constants

          class Index < TITLED_MENU
            include Constants
          end

          class NowPlaying < STATIC_MENU
            include Constants
          end
        end
      end
    end
  end
end
