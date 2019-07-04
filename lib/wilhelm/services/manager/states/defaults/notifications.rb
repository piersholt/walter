# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      module Defaults
        # Manager::Defaults
        module Notifications
          def device_connected(*); end

          def device_disconnected(*); end

          def device_connecting(*); end

          def device_disconnecting(*); end

          def new_device(*); end
        end
      end
    end
  end
end
