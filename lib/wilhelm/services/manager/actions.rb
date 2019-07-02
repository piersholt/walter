# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Actions
      module Actions
        include Logging

        def connect_device(device_address)
          logger.debug(MANAGER) { "#connect_device(#{device_address})" }
          @state.connect_device(self, device_address)
        end

        def disconnect_device(device_address)
          logger.debug(MANAGER) { "#disconnect_device(#{device_address})" }
          @state.disconnect_device(self, device_address)
        end
      end
    end
  end
end
