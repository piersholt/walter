# frozen_string_literal: true

# # require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module Radio
    include CommandAliases
    include BaseAPI

    # CD CHANGER

    def cd_changer_request(from: :rad, to: :cdc, arguments:)
      try(from, to, CDC_REQ, arguments)
    end

    # MENU

    def interface(from: :rad, to: :gfx, arguments:)
      try(from, to, MENU_RAD, arguments)
    end

    def config(from: :gfx, to: :rad, arguments:)
      try(from, to, MENU_GFX, arguments)
    end

    # DISPLAY

    def output(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_GFX, arguments)
    end

    def output_alt(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_NAV, arguments)
    end

    def index(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_MID, arguments)
    end
  end
end
