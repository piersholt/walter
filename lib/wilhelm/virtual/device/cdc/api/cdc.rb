# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module CDC
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Virtual::API::BaseAPI

          def cd_changer_status(from: :cdc, to: :rad, arguments:)
            try(from, to, CDC_REP, arguments)
          end
        end
      end
    end
  end
end
