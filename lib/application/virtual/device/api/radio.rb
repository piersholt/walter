# frozen_string_literal: true

# # require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module Radio
    include CommandAliases
    include BaseAPI

    # CD CHANGER

    def cd_changer_request(from: :rad, to: :cdc, arguments:)
      try(from, to, 0x38, arguments)
    end

    # MENU

    def interface(from: :rad, to: :gfx, arguments:)
      try(from, to, 0x46, arguments)
    end

    def config(from: :gfx, to: :rad, arguments:)
      try(from, to, 0x45, arguments)
    end

    # DISPLAY

    def output(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, 0x23, arguments)
    end

    def output_alt(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, 0xa5, arguments)
    end

    def index(from: :rad, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, 0x21, arguments)
    end
  end
end
