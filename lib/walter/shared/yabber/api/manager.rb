# frozen_string_literal: true

module Messaging
  module API
    # Comment
    module Manager
      include Constants

      # def device_list
      #   thy_will_be_done!(DEVICE, DEVICES)
      # end

      def devices!(callback)
        so?(DEVICE, DEVICES, {}, callback)
      end

      # def device_list?
      #   so?(DEVICE, DEVICES)
      # end

      def connect(device_address)
        thy_will_be_done!(DEVICE, CONNECT, address: device_address)
      end

      def disconnect(device_address)
        thy_will_be_done!(DEVICE, DISCONNECT, address: device_address)
      end
    end
  end
end
