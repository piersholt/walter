# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module TTY
        # UART Configuration
        module Configuration
          module Default
            BAUD         = 9600
            DATA_BITS    = 8
            STOP_BITS    = 1
            PARITY       = SerialPort::EVEN
            FLOW_CONTROL = SerialPort::HARD
          end
          include Default
        end
      end
    end
  end
end
