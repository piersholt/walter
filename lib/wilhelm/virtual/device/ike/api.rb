# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          # 0x2A ANZV-BOOL
          def api_2a(from: :ike, to: :anzv, **arguments)
            try(from, to, ANZV_BOOL, arguments)
          end

          # 0x24 ANZV-VAR
          def api_24(from: :ike, to: :anzv, **arguments)
            # format_chars!(arguments)
            try(from, to, ANZV_VAR, arguments)
          end
        end
      end
    end
  end
end
