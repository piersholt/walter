# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # Diagnostics
          module Diagnostics
            include Device::API::BaseAPI

            # 0xa0 DIA-A0
            def a0(from: :gt, to: :dia, arguments:)
              try(from, to, 0xa0, arguments)
            end
          end
        end
      end
    end
  end
end
