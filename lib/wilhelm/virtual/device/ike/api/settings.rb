# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # API for command related to keys
          module Settings
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x24 ANZV-VAR-IKE
            def anzv_var(from: :ike, to: :anzv, **arguments)
              # format_chars!(arguments)
              try(from, to, ANZV_VAR, arguments)
            end

            def anzv_var!(field, chars)
              anzv_var(field: field, ike: 0x00, chars: chars.bytes)
            end

            # 0x2a ANZV-BOOL-IKE
            def anzv_bool(from: :ike, to: :anzv, **arguments)
              try(from, to, ANZV_BOOL, arguments)
            end

            def boolean!(b1, b2)
              anzv_bool(b1: b1, b2: b2)
            end
          end
        end
      end
    end
  end
end
