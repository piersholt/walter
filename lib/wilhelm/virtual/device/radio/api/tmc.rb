# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module API
          # TMC
          module TMC
            include Device::API::BaseAPI

            # 0xa8 TMC
            def a8(from: :rad, to: :nav, arguments:)
              try(from, to, 0xa8, arguments)
            end
          end
        end
      end
    end
  end
end
