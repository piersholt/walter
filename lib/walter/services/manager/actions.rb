# frozen_string_literal: true

class Walter
  class Manager
    # Comment
    module Actions
      include Constants

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
