# frozen_string_literal: true

module Wilhelm
  class Virtual
    module API
      # API for command related to keys
      module CDChanger
        include Wilhelm::Virtual::Constants::Command::Aliases
        include BaseAPI

        def cd_changer_status(from: :cdc, to: :rad, arguments:)
          try(from, to, CDC_REP, arguments)
        end
      end
    end
  end
end
