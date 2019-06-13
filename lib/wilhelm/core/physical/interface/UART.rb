# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class Interface
      # There's two elements that differentiate this from a log file
      # 1. TTY Device which will be any serial binary data stream
      # 2. IBUS which is specific TTY configuration (profile?)
      class UART
        extend Forwardable

        DEFAULT_TTY_CONFIGURATION =
          { 'baud' => 9600,
            'data_bits' => 8,
            'stop_bits' => 1,
            'parity' => SerialPort::EVEN }.freeze
        DEFAULT_TTY_OPTIONS =
          { 'modem_params='.to_sym => DEFAULT_TTY_CONFIGURATION,
            'flow_control='.to_sym => SerialPort::HARD }.freeze

        FBVZ_CONFIGURATION =
          { 'baud' => 1800,
            'data_bits' => 8,
            'stop_bits' => 1,
            'parity' => SerialPort::EVEN }.freeze
        FBVZ_TTY_OPTIONS =
          { 'modem_params='.to_sym => FBVZ_CONFIGURATION,
            'flow_control='.to_sym => SerialPort::HARD }.freeze

        # delegate_serial_port_methods
        SerialPort.public_instance_methods(false).each do |method|
          LogActually.interface.debug('Device') { "Delegating: #{method} to SerialPort" }
          def_delegator :@stream, method
        end

        # delegate_io_methods
        def_delegators :@stream, :pos, :readpartial, :write, :write_nonblock

        attr_reader :stream

        alias_method :serial_port, :stream

        def initialize(path = DEFAULT_PATH, options = DEFAULT_TTY_OPTIONS)
          LogActually.interface.debug("#{self.class}#new(#{path}, #{options})")
          if options.nil? || options.empty?
            LogActually.interface.debug("Using default options: #{DEFAULT_TTY_OPTIONS}")
            options = DEFAULT_TTY_OPTIONS
          end

          serial_port = SerialPort.new(path, options)
          options.each do |option, value|
            serial_port.public_send(option, value)
          end

          @stream = serial_port
        end
      end
    end
  end
end
