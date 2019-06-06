# frozen_string_literal: true

module API
  # Comment
  module GFX
    include Command::Aliases
    include BaseAPI

    # MENU/USER INTERFACE

    # 0x46 MENU-GFX
    def config(from: :gfx, to: :rad, arguments:)
      try(from, to, MENU_GFX, arguments)
    end

    # 0x4E SND-SRC
    def sound_source(from: :gfx, to: :rad, arguments:)
      try(from, to, SRC_SND, arguments)
    end

    # 0x23
    def user_input(from: :gfx, to: :rad, **arguments)
      try(from, to, 0x31, arguments)
    end

    # # 0x4F SRC-GFX
    # # @param action
    # # @param nav
    # def sound_source(from: :tv, to: :bmbt, arguments:)
    #   try(from, to, SRC_GFX, arguments)
    # end
  end
end
