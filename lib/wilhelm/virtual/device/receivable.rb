class Virtual
  class Device
    module Receivable
      include Event

      def virtual_receive(message)
        message
      end

      def virtual_transmit(message)
        message
      end
    end
  end
end