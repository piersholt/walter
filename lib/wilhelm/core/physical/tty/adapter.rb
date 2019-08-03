# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module TTY
        # Sigh...
        class SerialPortAdapter
          extend Forwardable

          def_delegators :serial_port, *IO.instance_methods(false)
          def_delegators :serial_port, *SerialPort.instance_methods(false)

          attr_reader :serial_port

          def initialize(path)
            @serial_port = SerialPort.new(path)
          end
        end
      end
    end
  end
end
