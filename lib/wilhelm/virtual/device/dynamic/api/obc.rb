# frozen_string_literal: true

module Wilhelm
  module Virtual
    module API
      # Comment
      module OBC
        include Wilhelm::Virtual::Constants::Command::Aliases
        include BaseAPI

        # 0x40
        def obc_config(from: :gfx, to: :ike, **arguments)
          LOGGER.unknown('API::OBC') { "#{from}, #{to}, #{arguments}" }
          try(from, to, OBC_CONFIG, arguments)
        end

        # 0x2A
        def obc_ctl(from: :ike, to: :anzv, **arguments)
          LOGGER.unknown('API::OBC') { "#{from}, #{to}, #{arguments}" }
          try(from, to, OBC_CTL, arguments)
        end
      end
    end
  end
end
