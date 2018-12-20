# frozen_string_literal: true

# # require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module CDChanger
    include CommandAliases
    include BaseAPI

    def cd_changer_status(from: :cdc, to: :rad, arguments:)
      try(from, to, CDC_REP, arguments)
    end
  end
end
