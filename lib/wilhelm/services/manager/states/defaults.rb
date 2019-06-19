# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      # Unimplemented methods fallback for states
      module Defaults
        include Logging

        # STATES --------------------------------------------------

        def disable(___)
          false
        end

        def enable(___)
          false
        end

        def on(___)
          false
        end

        # Commands

        def connect_device(___)
          false
        end

        def disconnect_device(___)
          false
        end

        # Notifications ------------------------------------------------

        def device_connected(___, ___)
          false
        end

        def device_disconnected(___, ___)
          false
        end

        def device_connecting(___)
          false
        end

        def device_disconnecting(___)
          false
        end

        def new_device(___)
          false
        end
      end
    end
  end
end
