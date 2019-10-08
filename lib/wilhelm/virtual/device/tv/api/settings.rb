# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TV
        module API
          # Settings/Configuration commands
          module Settings
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x41 OBC-BOOL
            def obc_bool(from: :tv, to: :ike, **arguments)
              try(from, to, OBC_BOOL, arguments)
            end
          end
        end
      end
    end
  end
end
