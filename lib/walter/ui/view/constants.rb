# frozen_string_literal: false

class Walter
  class UserInterface
    module View
      # Walter constants
      module Constants
        BASIC_MENU      = Wolfgang::UserInterface::View::BasicMenu
        TITLED_MENU     = Wolfgang::UserInterface::View::TitledMenu
        STATIC_MENU     = Wolfgang::UserInterface::View::StaticMenu
      end

      # Comment
      module Header
        DEFAULT_HEADER  = Wolfgang::UserInterface::View::DefaultHeader
      end

      # Comment
      module Bluetooth
        include Constants
      end

      # Comment
      module Audio
        include Constants
      end
    end
  end
end
