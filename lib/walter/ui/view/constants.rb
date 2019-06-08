# frozen_string_literal: false

class Walter
  class UserInterface
    module View
      # Walter constants
      module Constants
        BASIC_MENU      = Wolfgang::UserInterface::View::BasicMenu
        TITLED_MENU     = Wolfgang::UserInterface::View::TitledMenu
        STATIC_MENU     = Wolfgang::UserInterface::View::StaticMenu

        CHECKED_ITEM    = Wolfgang::UserInterface::View::CheckedItem
        BASE_MENU_ITEM    = Wolfgang::UserInterface::View::BaseMenuItem
      end

      # Comment
      module Header
        DEFAULT_HEADER  = Wolfgang::UserInterface::View::DefaultHeader
      end

      # Comment
      module Bluetooth
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
