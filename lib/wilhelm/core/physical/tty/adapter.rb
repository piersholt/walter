# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module TTY
        # Sigh...
        class SerialPortAdapter
          extend Forwardable

          def_delegators :serial_port, :readpartial, :write, :write_nonblock
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
