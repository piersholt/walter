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

            # 0x2a ANZV-BOOL-IKE
            def anzv_bool(from: :ike, to: :anzv, **arguments)
              try(from, to, ANZV_BOOL, arguments)
            end

            def boolean!(control_a, control_b)
              anzv_bool(control_a: control_a, control_b: control_b)
            end
          end
        end
      end
    end
  end
end
