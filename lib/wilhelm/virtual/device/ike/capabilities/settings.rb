# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          # Device::IKE::Capabilities::Settings
          module Settings
            include API
            include Helpers::Data

            def output(field = 0x00, chars = genc(10))
              anzv_var(from: :ike, field: field, ike: 0x30, chars: chars)
            end

            alias write output
          end
        end
      end
    end
  end
end
