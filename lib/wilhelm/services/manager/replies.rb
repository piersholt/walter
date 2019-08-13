# frozen_string_literal: true

require_relative 'replies/devices'
require_relative 'replies/device'

module Wilhelm
  module Services
    class Manager
      # Manager::Replies
      module Replies
        include Logging
        include Devices
        include Device

        def device_update(context, path, device_state)
          logger.debug(stateful) { "#device_update(#{path})" }
          context.devices.update(device_state[:properties], device_state[:state])
        end
      end
    end
  end
end
