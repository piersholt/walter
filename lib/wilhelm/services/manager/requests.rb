# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Requests
      module Requests
        include Logging

        # Manager::Enabled.initialize ->
        def devices?
          logger.debug(MANAGER) { '#devices?' }
          logger.info(MANAGER) { '[REQUEST] Devices.' }
          devices!(devices_callback(self))
        end

        def device?(device_path)
          logger.debug(MANAGER) { "#device?(#{device_path})" }
          logger.info(MANAGER) { "[REQUEST] Device: #{device_path}." }
          device!(device_path, device_callback(self))
        end
      end
    end
  end
end
