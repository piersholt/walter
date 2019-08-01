# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class Device
        # Manager::Device::Actions
        module Actions
          include Yabber::API

          def connect
            return false if connected? || pending?
            connect!(id)
          end

          def disconnect
            return false if disconnected? || pending?
            disconnect!(id)
          end
        end
      end
    end
  end
end
