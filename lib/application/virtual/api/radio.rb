# frozen_string_literal: true

# require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module Radio
    include CommandAliases
    include BaseAPI

    def cd_changer_request(from: :rad, to: :cdc, arguments:)
      try(from, to, 0x38, arguments)
    end

    def interface(from: :rad, to: :gfx, arguments:)
      try(from, to, 0x46, arguments)
    end

    def config(from: :gfx, to: :rad, arguments:)
      try(from, to, 0x45, arguments)
    end
  end
end
