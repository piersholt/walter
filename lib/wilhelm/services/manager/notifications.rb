# frozen_string_literal: true

module Wilhelm
  class Manager
    # Comment
    module Notifications
      def device_connecting(properties)
        @state.device_connecting(self, properties)
      end

      def device_connected(properties)
        @state.device_connected(self, properties)
      end

      def device_disconnecting(properties)
        @state.device_disconnecting(self, properties)
      end

      def device_disconnected(properties)
        @state.device_disconnected(self, properties)
      end

      def new_device(properties)
        @state.new_device(self, properties)
      end
    end
  end
end
