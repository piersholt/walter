require 'forwardable'
require 'serialport'

# @deprecated
class Channel
  class Device
    extend Forwardable

    DEFAULT_PARAMS =
      { 'baud' => 9600, 'data_bits' => 8, 'stop_bits' => 1, 'parity' => 2 }.freeze
    DEFAULT_OPIONS = { 'modem_params='.to_sym => DEFAULT_PARAMS,
                       'flow_control='.to_sym => SerialPort::HARD }.freeze

    # def_delegators :serial_port, :readpartial, :pos
    SerialPort.public_instance_methods(false).each do |method|
      LOGGER.debug "Delegating: #{method} to #{:@stream}"
      def_delegator :@stream, method
    end

    # def_delegator :@stream, :modem_params

    attr_reader :stream

    alias_method :serial_port, :stream

    def initialize(path = DEFAULT_PATH, options = DEFAULT_OPIONS)
      serial_port = SerialPort.new(path, options)
      options.each do |option, value|
        serial_port.public_send(option, value)
      end

      @stream = serial_port
      # @serial_methods = serial_port.public_methods(false)
      true
    end
  end

  class Channel::Offline
    def initialize(path, *options)
      ARGF
    end
  end
end
