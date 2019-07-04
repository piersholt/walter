# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Actions
      module Actions
        include Logging

        # via ManagerControllers
        def connect_device(device_address)
          logger.debug(MANAGER) { "#connect_device(#{device_address})" }
          @state.connect_device(self, device_address)
        end

        # via ManagerControllers
        def disconnect_device(device_address)
          logger.debug(MANAGER) { "#disconnect_device(#{device_address})" }
          @state.disconnect_device(self, device_address)
        end

        # via Controls
        def load_manager(toggle)
          logger.debug(MANAGER) { "#load_manager(#{toggle})" }
          @state.load_manager(self, toggle)
        end
      end
    end
  end
end
