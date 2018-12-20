# frozen_string_literal: true

# # require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module Radio
    include CommandAliases
    include BaseAPI

    # CD CHANGER

    # 0x3?
    def cd_changer_request(from: :rad, to: :cdc, arguments:)
      try(from, to, CDC_REQ, arguments)
    end

    # MENU/USER INTERFACE

    # 0x46 MENU-RAD
    def interface(from: :rad, to: :gfx, arguments:)
      try(from, to, MENU_RAD, arguments)
    end

    # 0x37 RAD-ALT
    def mode(from: :rad, to: :gfx, **arguments)
      try(from, to, 0x37, arguments)
    end

    # DISPLAY

    # 0x23
    def primary(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_GFX, arguments)
    end

    # 0xA5
    def secondary(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_NAV, arguments)
    end

    # 0x21
    def list(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_MID, arguments)
    end
  end
end
