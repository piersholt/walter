# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      # Unimplemented methods fallback for states
      module Defaults
        include Logging

        # STATES --------------------------------------------------

        def disable(*)
          false
        end

        def enable(*)
          false
        end

        def on(*)
          false
        end

        # Commands

        def connect_device(*)
          false
        end

        def disconnect_device(*)
          false
        end

        # Notifications ------------------------------------------------

        def device_connected(*)
          false
        end

        def device_disconnected(*)
          false
        end

        def device_connecting(*)
          false
        end

        def device_disconnecting(*)
          false
        end

        def new_device(*)
          false
        end
      end
    end
  end
end
