# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class Device
        # Manager::Device::Actions
        module Actions
          include Yabber::API

          def connect
            connect!(id)
          end

          def disconnect
            disconnect!(id)
          end
        end
      end
    end
  end
end
