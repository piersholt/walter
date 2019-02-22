# frozen_string_literal: true

module API
  # Comment
  module OBC
    include CommandAliases
    include BaseAPI

    # 0x40
    def obc_config(from: :gfx, to: :ike, **arguments)
      LogActually.default.unknown('API::OBC') { "#{from}, #{to}, #{arguments}" }
      try(from, to, OBC_CONFIG, arguments)
    end
  end
end
