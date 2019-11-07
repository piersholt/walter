# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module API
          # Diagnostics
          module Diagnostics
            include Device::API::BaseAPI

            # 0xa0 DIA-A0
            def a0(from: :rad, to: :dia, arguments:)
              try(from, to, 0xa0, arguments)
            end

            # 0xb0 DIA-B0
            def b0(from: :rad, to: :dia, arguments:)
              try(from, to, 0xb0, arguments)
            end
          end
        end
      end
    end
  end
end
