# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # GT::API::Controls
          module Controls
            include Device::API::BaseAPI

            # 0x31 SOFT-INPUT
            # @param Integer layout
            # @param Integer function
            # @param Integer button
            def soft_input(from: :gt, to:, **arguments)
              try(from, to, INPUT, arguments)
            end

            alias user_input soft_input
          end
        end
      end
    end
  end
end
