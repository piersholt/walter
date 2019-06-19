# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Receivable
        include Wilhelm::Core::Constants::Events

        def virtual_receive(message)
          message
        end

        def virtual_transmit(message)
          message
        end
      end
    end
  end
end
