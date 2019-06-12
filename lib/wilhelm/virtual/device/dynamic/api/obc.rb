# frozen_string_literal: true

module Wilhelm::Virtual::API
  # Comment
  module OBC
    include Command::Aliases
    include BaseAPI

    # 0x40
    def obc_config(from: :gfx, to: :ike, **arguments)
      LogActually.default.unknown('API::OBC') { "#{from}, #{to}, #{arguments}" }
      try(from, to, OBC_CONFIG, arguments)
    end

    # 0x2A
    def obc_ctl(from: :ike, to: :anzv, **arguments)
      LogActually.default.unknown('API::OBC') { "#{from}, #{to}, #{arguments}" }
      try(from, to, OBC_CTL, arguments)
    end
  end
end
