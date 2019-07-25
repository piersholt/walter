# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Actions
      module Actions
        include Logging

        # via ManagerControllers
        def connect_device(device)
          logger.debug(MANAGER) { "#connect_device(#{device})" }
          @state.connect_device(self, device)
        end

        # via ManagerControllers
        def disconnect_device(device)
          logger.debug(MANAGER) { "#disconnect_device(#{device})" }
          @state.disconnect_device(self, device)
        end

        # via Controls
        def load_manager
          logger.debug(MANAGER) { "#load_manager" }
          @state.load_manager(self)
        end
      end
    end
  end
end
