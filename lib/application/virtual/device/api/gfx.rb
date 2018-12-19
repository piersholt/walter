# frozen_string_literal: true

module API
  # Comment
  module GFX
    include CommandAliases
    include BaseAPI

    def config(from: :gfx, to: :rad, arguments:)
      try(from, to, MENU_GFX, arguments)
    end
  end
end
